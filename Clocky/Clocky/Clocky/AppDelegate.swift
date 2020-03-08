//
//  AppDelegate.swift
//  Clocky
//
//  Created by RAJ RAVAL on 01/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Cocoa

let REMINDERS_WINDOW_CONTROLLER: NSWindowController = NSWindowController(window: nil)

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var timer: Timer? = nil
    var seperatorStatus: NSControl.StateValue = .on
    var reminders: [Reminder] = [] {
        didSet {
            if let menu = statusBarItem.menu, let item = menu.item(withTag: 5) {
                item.submenu = self.getRemindersMenu()
                item.isEnabled = reminders.count > 0
            }
        }
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        if Preferences.firstRunGone == false {
            Preferences.firstRunGone = true
            Preferences.restore()
        }
        DockIcon.standard.setVisibility(Preferences.showDockIcon)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        guard let statusButton = statusBarItem.button else { return }
        statusButton.title = Preferences.showSeconds ? Date.now.stringTimeWithSeconds : Date.now.stringTime
        
        timer = Timer.scheduledTimer(
            timeInterval: 1, target: self,
            selector: #selector(updateStatusText),
            userInfo: nil,
            repeats: true
        )
        
        let statusMenu: NSMenu = NSMenu()
        
        statusMenu.addItem(
            withTitle: "Good \(Date.now.isMorning ? "Morning" : "Evening")",
            action: nil,
            keyEquivalent: ""
        )
        statusMenu.addSeperator()
        
        let toggleFlashingSeparatorsItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Flashing Separators",
                action: #selector(toggleFlashingSeparators),
                keyEquivalent: ""
            )
            
            item.tag = 1
            item.target = self
            item.state = Preferences.useFlashDots.stateValue
            
            return item
        }()
        
        let toggleDockIconItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Toggle Dock Icon",
                action: #selector(toggleDockIcon),
                keyEquivalent: ""
            )
            
            item.tag = 2
            item.target = self
            item.state = Preferences.showDockIcon.stateValue
            
            return item
        }()
        
        let toggleSecondsItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Show seconds",
                action: #selector(toggleSeconds),
                keyEquivalent: ""
            )
            
            item.tag = 3
            item.target = self
            item.state = Preferences.showSeconds.stateValue
            
            return item
        }()
        
        let quitApplicationItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Quit",
                action: #selector(terminate),
                keyEquivalent: ""
            )
            
            item.target = self
            return item
        }()
        
        let remindersItem: NSMenuItem = {
            let item = NSMenuItem(title: "Reminders", action: nil, keyEquivalent: "")
            item.tag = 5
            
            let menu = NSMenu()
            
            for reminder in self.reminders {
                menu.addItem(.init(title: reminder.title, action: nil, keyEquivalent: ""))
            }
            
            item.isEnabled = reminders.count > 0
            
            return item
        }()
        
        let addReminderItem: NSMenuItem = {
            let item = NSMenuItem(title: "New Reminder", action: #selector(addReminder), keyEquivalent: "")
            item.tag = 6
            item.target = self
            return item
        }()
        
        statusMenu.addItems(
            remindersItem,
            addReminderItem,
            .separator(),
            toggleFlashingSeparatorsItem,
            toggleDockIconItem,
            .separator(),
            toggleSecondsItem,
            .separator(),
            quitApplicationItem
        )
        
        statusBarItem.menu = statusMenu
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
}

// MARK: NSMenuItems Actions

extension AppDelegate {
    
    @objc func updateStatusText(_ sender: Timer) {
        guard let statusButton = statusBarItem.button else { return }
        var title: String = (Preferences.showSeconds ? Date.now.stringTimeWithSeconds : Date.now.stringTime)
        
        if Preferences.useFlashDots && seperatorStatus == .on {
            seperatorStatus = .off
            title = title.replacingOccurrences(of: ":", with: " ")
        } else {
            seperatorStatus = .on
        }
        
        statusButton.title = title
        
        print(Date.now.stringTimeWithSeconds)
        
    }
    
    @objc func toggleFlashingSeparators(_ sender: NSMenuItem) {
        Preferences.useFlashDots = !Preferences.useFlashDots
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 1) {
            item.state = Preferences.useFlashDots.stateValue
        }
        
    }
    
    @objc func toggleDockIcon(_ sender: NSMenuItem) {
        Preferences.showDockIcon = !Preferences.showDockIcon
        
        DockIcon.standard.setVisibility(Preferences.showDockIcon)
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 2) {
            item.state = Preferences.showDockIcon.stateValue
        }
    }
    
    @objc func toggleSeconds(_ sender: NSMenuItem) {
        Preferences.showSeconds = !Preferences.showSeconds
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 3) {
            item.title = "Show seconds"
            item.state = Preferences.showSeconds.stateValue
        }
    }
    
    @objc func terminate(_ sender: NSMenuItem) {
        NSApp.terminate(sender)
    }
    
    private func getRemindersMenu() -> NSMenu {
        
        let menu = NSMenu()
        
        for reminder in self.reminders {
            menu.addItem(.init(title: reminder.title, action: nil, keyEquivalent: ""))
        }
        
        return menu
        
    }
    
    @objc func addReminder(_ sender: NSMenuItem) {
        if let vc = WindowsManager.getVC(withIdentifier: "NewReminderViewController", ofType: NewReminderViewController.self) {
            
            vc.delegate = self
            
            let window: NSWindow = {
                let w = NSWindow(contentViewController: vc)
                w.styleMask.remove(.fullScreen)
                w.styleMask.remove(.resizable)
                w.styleMask.remove(.miniaturizable)
                w.level = .floating
                
                return w
            }()
            
            if REMINDERS_WINDOW_CONTROLLER.window == nil {
                REMINDERS_WINDOW_CONTROLLER.window = window
            }
            
            REMINDERS_WINDOW_CONTROLLER.showWindow(self)
            
        }
    }
    
}

extension AppDelegate: NewReminderViewControllerDelegate, ReminderDelegate {
    
    func onSubmit(_ sender: NSButton, reminder: Reminder) {
        
        reminder.delegate = self
        
        if reminder.tag == nil {
            reminder.tag = reminders.count
        }
        
        REMINDERS_WINDOW_CONTROLLER.close()
        reminders.append(reminder)
        
    }
    
    func onReminderFired(_ reminder: Reminder) {
        reminders.removeAll(where: { $0.tag == reminder.tag })
    }
    
}
