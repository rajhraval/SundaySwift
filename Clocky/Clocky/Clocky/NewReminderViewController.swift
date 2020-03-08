//
//  NewReminderViewController.swift
//  Clocky
//
//  Created by RAJ RAVAL on 08/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Cocoa

protocol NewReminderViewControllerDelegate {
    func onSubmit(_ sender: NSButton, reminder: Reminder) -> Void
}

class NewReminderViewController: NSViewController {
    
    @IBOutlet var taskTitle: NSTextField!
    @IBOutlet var taskDate: NSDatePicker!
    @IBOutlet var taskDescription: NSTextView!
    
    var delegate: NewReminderViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        taskTitle.stringValue = ""
        taskDescription.string = ""
        taskDate.calendar = Calendar.current
        taskDate.dateValue = Date.now
    }
    
    @IBAction func onSubmit(_ sender: NSButton) {
        let reminder = Reminder(taskTitle.stringValue, description: taskDescription.string, fireOnDate: taskDate.dateValue, tag: nil)
        
        delegate.onSubmit(sender, reminder: reminder)
    }
}
