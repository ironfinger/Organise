//
//  AddTaskCompletionViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 02/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddTaskCompletionViewController: UIViewController {
    
    // Outlets:
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDayLabel: UILabel!
    @IBOutlet weak var taskWeekLabel: UILabel!
    @IBOutlet weak var taskStartTimeLabel: UILabel!
    @IBOutlet weak var taskEndTimeLabel: UILabel!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    
    // Variables:
    var newTimetableSlot = TimetableSlot()
    var newTask = Task()
    var addType = ""
    
    // MARK: View setup.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        print("Add Type \(addType)")
    }
    
    func setupView() {
        // Sub View:
        subView.layer.cornerRadius = 20
        // Add Task Button:
        addTaskButton.backgroundColor = UIColor.white
        addTaskButton.layer.cornerRadius = 10
        setTaskLabels()
        assignViewColors() // This sets up the color theme based on the task colour that the user chose.
    }
    
    func setTaskLabels() {
        // Task labels:
        // Mask to bounds to get the corner radius to work
        taskNameLabel.layer.masksToBounds = true
        taskDayLabel.layer.masksToBounds = true
        taskWeekLabel.layer.masksToBounds = true
        taskStartTimeLabel.layer.masksToBounds = true
        taskEndTimeLabel.layer.masksToBounds = true
        taskDescriptionTextView.layer.masksToBounds = true
        
        taskNameLabel.layer.cornerRadius = 10
        taskDayLabel.layer.cornerRadius = 10
        taskWeekLabel.layer.cornerRadius = 10
        taskStartTimeLabel.layer.cornerRadius = 10
        taskEndTimeLabel.layer.cornerRadius = 10
        taskDescriptionTextView.layer.cornerRadius = 10
        
        taskNameLabel.text = "Name: \(newTimetableSlot.name)" // Task Name.
        taskDayLabel.text = "Day: \(newTimetableSlot.weekDay)" // Task Day
        taskWeekLabel.text = "Week: \(newTimetableSlot.week)" // Task Week
        taskStartTimeLabel.text = "Start Time: \(newTimetableSlot.startTime)" // Task Start time.
        taskEndTimeLabel.text = "End Time: \(newTimetableSlot.endTime)" // Task end time.
        taskDescriptionTextView.text = "Description: \(newTimetableSlot.description)"
    }
    
    func assignViewColors() {
        let colorPallete = TaskColours()
        if (newTimetableSlot.color == "Default") {
            
        }else if (newTimetableSlot.color == "Red") {
            self.view.backgroundColor = colorPallete.red[0]
            self.subView.backgroundColor = colorPallete.red[1]
            
            // Labels:
            self.taskNameLabel.backgroundColor = colorPallete.red[0]
            self.taskDayLabel.backgroundColor = colorPallete.red[0]
            self.taskWeekLabel.backgroundColor = colorPallete.red[0]
            self.taskStartTimeLabel.backgroundColor = colorPallete.red[0]
            self.taskEndTimeLabel.backgroundColor = colorPallete.red[0]
            self.taskDescriptionTextView.backgroundColor = colorPallete.red[0]
            
        }else if (newTimetableSlot.color == "Blue") {
            self.view.backgroundColor = colorPallete.blue[0]
            self.subView.backgroundColor = colorPallete.blue[1]
            
            // Labels:
            self.taskNameLabel.backgroundColor = colorPallete.blue[0]
            self.taskDayLabel.backgroundColor = colorPallete.blue[0]
            self.taskWeekLabel.backgroundColor = colorPallete.blue[0]
            self.taskStartTimeLabel.backgroundColor = colorPallete.blue[0]
            self.taskEndTimeLabel.backgroundColor = colorPallete.blue[0]
            self.taskDescriptionTextView.backgroundColor = colorPallete.blue[0]
            
        }else if (newTimetableSlot.color == "Green") {
            self.view.backgroundColor = colorPallete.green[0]
            self.subView.backgroundColor = colorPallete.green[1]
            
            // Labels:
            self.taskNameLabel.backgroundColor = colorPallete.green[0]
            self.taskDayLabel.backgroundColor = colorPallete.green[0]
            self.taskWeekLabel.backgroundColor = colorPallete.green[0]
            self.taskStartTimeLabel.backgroundColor = colorPallete.green[0]
            self.taskEndTimeLabel.backgroundColor = colorPallete.green[0]
            self.taskDescriptionTextView.backgroundColor = colorPallete.green[0]
            
        }else if (newTimetableSlot.color == "Purple") {
            self.view.backgroundColor = colorPallete.purple[0]
            self.subView.backgroundColor = colorPallete.purple[1]
            
            // Labels:
            self.taskNameLabel.backgroundColor = colorPallete.purple[0]
            self.taskDayLabel.backgroundColor = colorPallete.purple[0]
            self.taskWeekLabel.backgroundColor = colorPallete.purple[0]
            self.taskStartTimeLabel.backgroundColor = colorPallete.purple[0]
            self.taskEndTimeLabel.backgroundColor = colorPallete.purple[0]
            self.taskDescriptionTextView.backgroundColor = colorPallete.purple[0]
            
        }
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        // Fetch userPath:
        let userPath = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
        
        if (addType == "Timetable") {
            pushTimetableSlotToDatabase(userPath: userPath) // Send timetableSlot to database.
        }else if (addType == "Task") {
            pushTaskToDatabase(userPath: userPath) // Send task to database.
        }
        performSegue(withIdentifier: "routeBackSegue", sender: nil) // Route back to home view controller.
    }
    
    func pushTimetableSlotToDatabase(userPath: DatabaseReference) {
        let data = [
            "timetableName": newTimetableSlot.name,
            "description": newTimetableSlot.description,
            "startTime": newTimetableSlot.startTime,
            "endTime": newTimetableSlot.endTime,
            "weekDay": newTimetableSlot.weekDay,
            "week": newTimetableSlot.week,
            "color": newTimetableSlot.color
        ] // Holds data in dictionary for database push.
        
        userPath.child("timetable").child(newTimetableSlot.week).child(newTimetableSlot.weekDay).childByAutoId().setValue(data) // Pushes data to database.
    }
    
    func pushTaskToDatabase(userPath: DatabaseReference) {
        let data = [
            "taskName": newTask.name,
            "description": newTask.description,
            "color": newTask.color,
            "time": newTask.time,
            "day": newTask.day,
        ] // Hold data in dictionary for database push.
        
        userPath.child("tasks").childByAutoId().setValue(data) // Pushes data to database.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
