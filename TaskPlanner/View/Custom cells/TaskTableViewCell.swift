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

protocol TaskProcessingDelegate {
    func taskRunning(buttonInRow: UIButton)
    func taskStopping()
}

enum buttonState: String {
    case Play = "stop.fill", Stop = "play.fill"
}
class TaskTableViewCell: UITableViewCell {
    
    var selectedButton2 = UIButton()
    static let notificationName = Notification.Name("passDataAboutTasks")
    
//    @objc func stopTaskUI() {
//      print("task")
//         selectedButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//       
//    }
     

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskToggleButton: UIButton!
    
    //var taskState: Bool = false
    var taskState: buttonState = .Play
   
   
    
    var taskProcessingDelegate: TaskProcessingDelegate?
    let taskController = TasksViewController()
    
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
        
       
      // check if there is anythingRunningAtTheMoment
        if (selectedButton.isSelected == true && indexPath.row != selectedPath) {
         
          selectedButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
           taskToggleButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            selectedButton = taskToggleButton
                    selectedButton.isSelected = true
        } else {
           
          // if not Launch it
            if (taskToggleButton.isSelected == false) {
                 taskToggleButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
                taskToggleButton.isSelected = true
                taskProcessingDelegate?.taskRunning(buttonInRow: taskToggleButton)
            } else {
                 taskToggleButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                taskToggleButton.isSelected = false
                 taskProcessingDelegate?.taskStopping()
            }
            
          
            selectedButton = taskToggleButton
         
           
        }
        
    
        selectedPath = indexPath.row
       
        switch taskState {
            
        case .Play: taskState = .Stop
        case .Stop: taskState = .Play
            
        }
    }
    
    
 
   
}
