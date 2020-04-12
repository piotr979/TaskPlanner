//
//  UserSettings.swift
//  TaskPlanner
//
//  Created by Start on 08/04/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation

//struct UserSettings {
//    
//     let defaults = UserDefaults.standard
//    
//    var timeValues: [Int] = [Int]()
//    let sounds: [String] = ["PowerLoad", "Striking"]
//    
//    init() {
//        buildTimeValuesArray()
//      
//    }
//    
//    
//    // Build array of time values
//      mutating func buildTimeValuesArray() {
//          for z in stride(from: 5, to: 65, by: 5)  {
//            timeValues.append(z)
//          }
//      }
//    
//    func loadSettings(key: String) ->Int {
//        if UserDefaults.contains(key) {
//            return defaults.integer(forKey: key)
//        }
//        return 0
//    }
//}
//
//extension UserDefaults {
//    static func contains(_ key: String) -> Bool {
//        return UserDefaults.standard.object(forKey: key) != nil
//    }
//}
