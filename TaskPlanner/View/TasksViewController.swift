//
//  FirstViewController.swift
//  TaskPlanner
//
//  Created by Start on 25/03/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import UIKit
import CoreData


class TasksViewController: UITableViewController, TaskProcessingDelegate {
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet var tasksTableView: UITableView!
    
    var bgTask = UIBackgroundTaskIdentifier.init(rawValue: 1)
    var timer = Timer()
    var counter = 0
    var selectedButtonRow: UIButton?
  
    var tasks = [Task]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        Settings.userSettings.loadSettings()
        bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
        UIApplication.shared.endBackgroundTask(self.bgTask)
        })
        
    
        tasksTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTaskCell")
      
        loadTasks()
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    //MARK: TableView overwritten methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTaskCell", for: indexPath) as! TaskTableViewCell
        cell.taskNameLabel.text = tasks[indexPath.row].taskName
       
        cell.indexPath = indexPath
    
      cell.taskProcessingDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            context.delete(tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            
            saveTasks()
            tableView.reloadData()
    }
        
    }
    
    //MARK: Actions
    @IBAction func addTask(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Task", message: "Enter name of new task", preferredStyle: .alert)
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "New task"
            textField = alertTextField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
       
        let newTask = Task(context: self.context)
        print(textField.text!)
        newTask.taskName = textField.text!
        newTask.taskTime = 15
        newTask.taskFinishedAmt = 0
        
        self.tasks.append(newTask)
        self.saveTasks()
        self.tableView.reloadData()
            
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    
    func saveTasks() {
        
            do {
                try context.save()
                } catch {
                    self.errorAlert("Cannot save \(error)")
            }
    }
    
        func errorAlert(_ errorText: String) {
            let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    func loadTasks(with request: NSFetchRequest<Task> = Task.fetchRequest(), predicate: NSPredicate? = nil) {
        
        request.predicate = predicate
        
        do {
            tasks = try context.fetch(request)
            
        } catch {
            self.errorAlert("Cannot fetch data")
        }
        tableView.reloadData()
        
        
    }
    //MARK: Tasks launching/stopping
   
    
    func taskRunning(buttonInRow: UIButton) {
        selectedButtonRow = buttonInRow
    
       
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(notificationReceived), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }

    func taskStopping() {
        
        navigationBar.prompt = NSLocalizedString("Task finished. Waiting for new one.", comment: "")
        counter = 0
      
        timer.invalidate()
        print("stopping")
        selectedButtonRow!.setImage(UIImage(systemName: "play.fill"), for: .normal)
    
        //NotificationCenter.default.post(name: TaskTableViewCell.notificationName, object: nil)
        
    }
    
    @objc
       func notificationReceived() {
           print(counter)
           navigationBar.prompt = NSLocalizedString("Task running. Time left:  \(counter)", comment: "")
           counter += 1
           if counter == 3 {
            
               taskStopping()
           }
       }
   
}



extension TasksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "taskName", ascending: true)]
        
        let predicate = NSPredicate(format: "taskName CONTAINS %@", searchBar.text!)
        
        loadTasks(with: request, predicate: predicate)
       
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count == 0) {
            loadTasks()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

