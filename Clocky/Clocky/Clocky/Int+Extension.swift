//
//  Int+Extension.swift
//  Clocky
//
//  Created by RAJ RAVAL on 01/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation

extension Int {
    var safeString: String {
        return self >= 10 ? "\(self)" : "0\(self)"
    }
}
