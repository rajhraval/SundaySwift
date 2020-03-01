//
//  Bool+Extension.swift
//  Clocky
//
//  Created by RAJ RAVAL on 01/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation
import AppKit

extension Bool {
    
    var stateValue: NSControl.StateValue {
        return self.toStateValue()
    }
    
    private func toStateValue() -> NSControl.StateValue {
        return self ? .on : .off
    }
    
}
