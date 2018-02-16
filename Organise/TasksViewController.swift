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
    
    // Variables:
    var tasks = [Task]()
    
    // MARK: View setup:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        databasePull() // Pull from database when view appears.
    }
    
    // MARK: Firebase Database Pull:
    func databasePull() {
        let userUID = Auth.auth().currentUser!.uid
        Database.database().reference().child("users").child(userUID).child("tasks").observe(DataEventType.childAdded, with: { (snapshot) in
            // Pull values from database:
            let value = snapshot.value as? NSDictionary
            let name = value?["taskName"] as? String ?? ""
            let description = value?["description"] as? String ?? ""
            let color = value?["color"] as? String ?? ""
            let time = value?["time"] as? String ?? ""
            let day = value?["day"] as? String ?? ""
            
            // Assign values to new array item:
            let newTask = Task()
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
        let cell = UITableViewCell()
        let name = tasks[indexPath.row].name
        let day = tasks[indexPath.row].day
        let cellText = "Task: \(name) || Day: \(day)"
        cell.textLabel!.text = cellText
        return cell
    }
    
    // MARK: Actions:
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddTaskViewController", sender: nil)
    }
    
    // MARK: Segue:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddTaskViewController
        nextVC.addType = "Task"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
