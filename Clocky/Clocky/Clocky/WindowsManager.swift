//
//  WindowsManager.swift
//  Clocky
//
//  Created by RAJ RAVAL on 08/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation
import AppKit

struct WindowsManager {
    
    static func getVC<T: NSViewController>(withIdentifier identifier: String, ofType: T.Type?, storyboard: String = "Main", bundle: Bundle? = nil) -> T? {
        
        let storyboard = NSStoryboard(name: storyboard, bundle: bundle)
        
        guard let vc: T = storyboard.instantiateController(withIdentifier: identifier) as? T else {
            let alert = NSAlert()
            alert.alertStyle = .critical
            alert.messageText = "Error initiating the View Controller."
            alert.runModal()
            
            return nil
        }
        
        return vc
    }
}
