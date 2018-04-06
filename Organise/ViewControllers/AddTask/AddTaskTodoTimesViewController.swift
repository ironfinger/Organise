//
//  AddTaskTaskTimesViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 05/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class AddTaskTodoTimesViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var datePickerSubView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // Variables:
    var newTask = Task()
    
    // MARK: View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewSetup()
    }
    
    func viewSetup() {
        // SubViews:
        self.subView.layer.cornerRadius = 20
        self.datePickerSubView.layer.cornerRadius = 20
        // Next button:
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 10
        
        assignViewColors() // Sets the view colors.
    }
    
    func assignViewColors() {
        let colorPallete = TaskColours()
        
        if (newTask.color == "Default") {
            
        }else if (newTask.color == "Red") {
            self.view.backgroundColor = colorPallete.red[0]
            self.subView.backgroundColor = colorPallete.red[1]
            self.datePickerSubView.backgroundColor = colorPallete.red[0]
            self.nextButton.tintColor = colorPallete.red[2]
        }else if (newTask.color == "Blue") {
            self.view.backgroundColor = colorPallete.blue[0]
            self.subView.backgroundColor = colorPallete.blue[1]
            self.datePickerSubView.backgroundColor  = colorPallete.blue[0]
            self.nextButton.tintColor = colorPallete.blue[2]
        }else if (newTask.color == "Green") {
            self.view.backgroundColor = colorPallete.green[0]
            self.subView.backgroundColor = colorPallete.green[1]
            self.datePickerSubView.backgroundColor = colorPallete.green[0]
            self.nextButton.tintColor = colorPallete.green[2]
        }else if (newTask.color == "Purple") {
            self.view.backgroundColor = colorPallete.purple[0]
            self.subView.backgroundColor = colorPallete.purple[2]
            self.datePickerSubView.backgroundColor = colorPallete.purple[0]
            self.nextButton.tintColor = colorPallete.purple[2]
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        pullDatePickerTimes()
        performSegue(withIdentifier: "TaskCompletetionSegue", sender: nil)
    }
    
    func pullDatePickerTimes() {
        let formatForDay = DateFormatter() // Holds the format for day.
        let formatForTime = DateFormatter() // Holds the format for times.
        
        formatForDay.dateFormat = "yyyy-MM-dd"
        formatForTime.dateFormat = "HH:mm"
        
        newTask.day = formatForDay.string(from: datePicker.date)
        newTask.time = formatForTime.string(from: datePicker.date)
        
        print("Task day and time")
        print(newTask.day)
        print(newTask.time)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddTaskCompletionViewController
        nextVC.newTask = newTask
        nextVC.addType = "Task"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
