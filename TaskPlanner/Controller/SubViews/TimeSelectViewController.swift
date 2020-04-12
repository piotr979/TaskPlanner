//
//  TimeSelectViewController.swift
//  TaskPlanner
//
//  Created by Start on 02/04/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import UIKit

protocol TimeSelectToParentViewDelegate {
    func passTimeBackToMainView(selectedTime: Int)
}

class TimeSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timeSelectPicker: UIPickerView!
    
    var delegate: TimeSelectToParentViewDelegate?
    var selectedTime: Int?
    
    override func viewDidLoad() {
          super.viewDidLoad()

          timeSelectPicker.selectRow(Settings.userSettings.defaultTimeMinutes, inComponent: 0, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
          if (isBeingDismissed == true ) {
            
            Settings.userSettings.saveSettings()
             self.delegate?.passTimeBackToMainView(selectedTime: timeSelectPicker.selectedRow(inComponent: 0))
          }
      }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Settings.userSettings.timeValues.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(Settings.userSettings.timeValues[row]) mins"
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
