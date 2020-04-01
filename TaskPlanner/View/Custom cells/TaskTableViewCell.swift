//
//  TaskTableViewCell.swift
//  TaskPlanner
//
//  Created by Start on 27/03/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import UIKit


 var selectedButton = UIButton()
 var selectedPath: Int = -1
enum buttonState: String {
    case Play = "stop.fill", Stop = "play.fill"
}
class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskToggleButton: UIButton!
    
    //var taskState: Bool = false
    var taskState: buttonState = .Play
   
   
   
    
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func toggleButton(_ sender: Any) {
        
        print("Index path is \(selectedPath)")
        print("\(indexPath.row)")
        
        print(selectedButton)
        print(selectedButton.isSelected)
        if (selectedButton.isSelected == true && indexPath.row != selectedPath) {
            print("Switch button")
          selectedButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
           taskToggleButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            selectedButton = taskToggleButton
                    selectedButton.isSelected = true
        } else {
            print("process off")
            print(selectedButton.isSelected)
            if (selectedButton.isSelected == true && indexPath.row == selectedPath ) {
                  taskToggleButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            } else {
     taskToggleButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            }
            selectedButton = taskToggleButton
          selectedButton.isSelected = true
           
        }
        
        
//        print(selectedButton.isSelected)
//        if (taskToggleButton != selectedButton && selectedButton.isSelected == true) {
//            print("not same")
//            print(selectedButton)
//            selectedButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//             taskToggleButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//            taskToggleButton.isSelected = true
//            selectedButton = taskToggleButton
//            return
//        }
//        if (taskToggleButton.isSelected == false) {
//            print("IS false")
//        taskToggleButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
//        taskToggleButton.isSelected = true
//        selectedButton = taskToggleButton
//        } else {
//             taskToggleButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//            taskToggleButton.isSelected = false
//        }
        
        
//        if taskToggleButton == selectedButton {
//            taskToggleButton.setImage(UIImage(systemName: taskState.rawValue), for: .normal)
//            print("selected")
//        }
//        if (selectedPath == nil) || (selectedPath == indexPath ) {)
//        } else {
//
//        }
        
        //jesli wciskam na button ktory jest stop - change to play it, second time stop it
        
     
//           // set Image of previous one to stop.fill
//            taskToggleButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
//        } else {
//             taskToggleButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//        }
        
        selectedPath = indexPath.row
        print("\(selectedPath)")
        switch taskState {
            
        case .Play: taskState = .Stop
        case .Stop: taskState = .Play
            
        }
    }
   
}
