//
//  SettingsCellsViewController.swift
//  TaskPlanner
//
//  Created by Start on 03/04/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import UIKit

class SettingsCellsViewController: UITableViewController, TimeSelectToParentViewDelegate, SelectedSoundDelegate {
    
    @IBOutlet weak var finishedSoundLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSettingsOnView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    if (segue.identifier == "selectTime") {
        let timeSelectVC = segue.destination as! TimeSelectViewController
        timeSelectVC.delegate = self
    }
        
    if (segue.identifier == "selectSound") {
        let soundSelectVC = segue.destination as! FinishedSoundTableViewController
        soundSelectVC.delegate = self
        }
    }
    
    func updateSettingsOnView() {
        
        finishedSoundLabel.text! = Settings.userSettings.sounds[Settings.userSettings.selectedSound]
        print(Settings.userSettings.defaultTimeMinutes)
        timeLabel.text! = "\(Settings.userSettings.timeValues[Settings.userSettings.defaultTimeMinutes]):00"
    }
    
    // MARK: - Delegates - Pass data from subviews
    
    func passSelectedSound(selectedSound: Int) {
        Settings.userSettings.selectedSound = selectedSound
        Settings.userSettings.saveSettings()
        updateSettingsOnView()
    }

    func passTimeBackToMainView(selectedTime: Int) {
        Settings.userSettings.defaultTimeMinutes = selectedTime
        Settings.userSettings.saveSettings()
        updateSettingsOnView()
    }

}
