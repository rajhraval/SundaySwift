//
//  FileManager-DocumentDirectory.swift
//  WatchReactions WatchKit Extension
//
//  Created by RAJ RAVAL on 25/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import Foundation

extension FileManager {
    func getDocumentsDirectory() -> URL {
        let paths = urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
