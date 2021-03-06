//
//  Others.swift
//  TaskPlanner
//
//  Created by Start on 02/04/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation
import UIKit
class Settings {
    
    let defaults = UserDefaults.standard
    
    var defaultTimeMinutes = 0
    var selectedSound = 0
    var volume: Float = 1.0
    
    // this array is generated by builtTimeValuesArray()
    var timeValues: [Int] = [Int]()
    let sounds: [String] = ["PowerLoad", "Striking"]
    
    static let userSettings = Settings()
    
    init() {
        buildTimeValuesArray()
        loadSettings()
    }
    
    
    // MARK: Load/Save operations
    
    func loadSettings() {
        if UserDefaults.contains("timeMinutes") {
            defaultTimeMinutes = defaults.integer(forKey: "timeMinutes")
            selectedSound = defaults.integer(forKey: "selectedSound")
        }
        
    }
    
    func saveSettings() {
        defaults.set(defaultTimeMinutes, forKey: "timeMinutes")
        defaults.set(selectedSound, forKey: "selectedSound")
    }
    
    // Build array of time values
    private func buildTimeValuesArray() {
        for z in stride(from: 5, to: 65, by: 5)  {
            timeValues.append(z)
        }
    }
}

extension UserDefaults {
    static func contains(_ key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
