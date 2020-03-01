//
//  NSMenu+Extension.swift
//  Clocky
//
//  Created by RAJ RAVAL on 01/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation
import AppKit

extension NSMenu {
    func addSeperator() -> Void {
        addItem(.separator())
    }
    
    func addItems(_ items: NSMenuItem...) {
        for item in items {
            addItem(item)
        }
    }
}
