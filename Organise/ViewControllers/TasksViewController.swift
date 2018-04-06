//
//  TasksViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 05/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // ISSUES:
    // Finish retreive date time info from date time tasks view controller!!!!!
    
    // Outlets:
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var navBar: UINavigationItem!
    
    // Variables:
    let colors = TaskColours()
    
    var tasks = [Task]()
    var indexOfCellToExpand = -1
    
    // MARK: View setup:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        // External table view loading:
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    // External table view loading
    @objc func loadList(notification: NSNotification) {
        // load data here:
        tasks.removeAll()
        indexOfCellToExpand = -1
        databasePull()
        self.view.setNeedsDisplay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tasks.removeAll() // Remove all before pulling from database again.
        databasePull() // Pull from database when view appears.
    }
    
    // MARK: Firebase Database Pull:
    func databasePull() {
        let userUID = Auth.auth().currentUser!.uid
        Database.database().reference().child("users").child(userUID).child("tasks").observe(DataEventType.childAdded, with: { (snapshot) in
            // Pull values from database:
            let value = snapshot.value as? NSDictionary
            let key = snapshot.key
            let name = value?["taskName"] as? String ?? ""
            let description = value?["description"] as? String ?? ""
            let color = value?["color"] as? String ?? ""
            let time = value?["time"] as? String ?? ""
            let day = value?["day"] as? String ?? ""
            
            // Assign values to new array item:
            let newTask = Task()
            newTask.key = key
            newTask.name = name
            newTask.description = description
            newTask.color = color
            newTask.time = time
            newTask.day = day

            // Append to array:
            self.tasks.append(newTask)
            
            // Reload tableView:
            self.tableView.reloadData()
        }) { (error) in
            if (error != nil) {
                print("We couldn't observe database \(error)")
            }else{
                print("We successfully observed database")
            }
        }
    }
    
    // Table View:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskViewCell", for: indexPath) as! TaskTableViewCell
        cell.associatedTask = tasks[indexPath.row]
        cell.taskNameLabel.text = tasks[indexPath.row].name
        cell.completeByLabel.text = getDescriptonText(des: tasks[indexPath.row].description)
        cell.timeCompletion.text = tasks[indexPath.row].time
        cell.completeTaskButton.tag = indexPath.row
        cell.completeTaskButton.addTarget(self, action: #selector(cellButtonClicked), for: UIControlEvents.touchUpInside)
        cell.taskSettingsButton.addTarget(self, action: #selector(cellSettingsButtonClicked), for: UIControlEvents.touchUpInside)
        
        // Set all the aesthetic features of the cell:
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.cellSubView.backgroundColor = colors.pullColorFromString(selectedColor: tasks[indexPath.row].color, shade: 2)
        cell.expandedSubView.backgroundColor = colors.pullColorFromString(selectedColor: tasks[indexPath.row].color, shade: 2)
        cell.expandedSubSubView.backgroundColor = colors.pullColorFromString(selectedColor: tasks[indexPath.row].color, shade: 1)
        cell.timeCompletion.backgroundColor = colors.pullColorFromString(selectedColor: tasks[indexPath.row].color, shade: 2)
        return cell
    }
    
    func getDescriptonText(des: String) -> String {
        if (des == "Task Description") {
            return ""
        }
        return des
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performSegue(withIdentifier: "viewTask", sender: nil)
        // Expand cell:
        cellExpansion(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == indexOfCellToExpand) {
            return 310
        }
        return 62
    }
    
    func cellExpansion(indexPath: IndexPath) {
        if (indexPath.row == indexOfCellToExpand) {
            indexOfCellToExpand = -1
        }else {
            indexOfCellToExpand = indexPath.row
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    // MARK: Actions:
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddTaskViewController", sender: nil)
    }
    
    @objc func cellButtonClicked() { // Called when the complete button is clicked
        print("Cell button Clicked")
        // Re-do table here.
        let selectedTask = tasks[indexOfCellToExpand]
        let userUID = Auth.auth().currentUser!.uid
        Database.database().reference().child("users").child(userUID).child("tasks").child(selectedTask.key).removeValue { (error, ref) in
            if (error != nil) {
                print("Couldn't delete \(String(describing: error))")
            }else{
                self.tasks.remove(at: self.indexOfCellToExpand)
                do {
                    try self.databasePull()
                    self.tableView.reloadData()
                } catch {
                    self.tasks.removeAll()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func cellSettingsButtonClicked() {
        print("Settings Pressed")
        performSegue(withIdentifier: "taskSettingsSegue", sender: nil)
    }
    
    // MARK: Segue:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddTaskViewController") {
            let nextVC = segue.destination as! AddTaskViewController
            nextVC.addType = "Task"

        }else if (segue.identifier == "taskSettingsSegue") {
            let nextVC = segue.destination as! TaskSettingViewController
            nextVC.task = tasks[indexOfCellToExpand]
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
