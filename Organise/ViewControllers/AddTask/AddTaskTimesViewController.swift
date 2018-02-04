//
//  AddTaskTimesViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 03/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class AddTaskTimesViewController: UIViewController {

    // Outlets:
    @IBOutlet weak var weekDaySegmentControl: UISegmentedControl!
    @IBOutlet weak var weekSegmentControl: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var startTimeSubView: UIView!
    @IBOutlet weak var endTimeSubView: UIView!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    
    // Variables:
    var newTimetableSlot = TimetableSlot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        print("View did load \(newTimetableSlot.name)")
        print("View did load description: \(newTimetableSlot.description)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear \(newTimetableSlot.name)")
        print("View did load description: \(newTimetableSlot.description)")
    }

    // View Setup.
    func setupView() {
        // Sub View:
        subView.layer.cornerRadius = 20
        // Start Time Sub View:
        startTimeSubView.layer.cornerRadius = 20
        // End Time Sub View:
        endTimeSubView.layer.cornerRadius = 20
        // Next button:
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 10
        
        assignViewColors()
    }
    
    func assignViewColors() {
        let colorPallete = TaskColours()
        if (newTimetableSlot.color == "Default") {
            
        }else if (newTimetableSlot.color == "Red") {
            self.view.backgroundColor = colorPallete.red[0]
            self.subView.backgroundColor = colorPallete.red[1]
            self.startTimeSubView.backgroundColor = colorPallete.red[0]
            self.endTimeSubView.backgroundColor = colorPallete.red[0]
        }else if (newTimetableSlot.color == "Blue") {
            self.view.backgroundColor = colorPallete.blue[0]
            self.subView.backgroundColor = colorPallete.blue[1]
            self.startTimeSubView.backgroundColor = colorPallete.blue[0]
            self.endTimeSubView.backgroundColor = colorPallete.blue[0]
        }else if (newTimetableSlot.color == "Green") {
            self.view.backgroundColor = colorPallete.green[0]
            self.subView.backgroundColor = colorPallete.green[1]
            self.startTimeSubView.backgroundColor = colorPallete.green[0]
            self.endTimeSubView.backgroundColor = colorPallete.green[0]
        }else if (newTimetableSlot.color == "Purple") {
            self.view.backgroundColor = colorPallete.purple[0]
            self.subView.backgroundColor = colorPallete.purple[1]
            self.startTimeSubView.backgroundColor = colorPallete.purple[0]
            self.endTimeSubView.backgroundColor = colorPallete.purple[0]
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        newTimetableSlot.startTime = pullTimes(startTime: true)
        newTimetableSlot.endTime = pullTimes(startTime: false)
        newTimetableSlot.weekDay = pullSelectedDay()
        newTimetableSlot.week = pullSelectedWeek()
        
        // Print all of these values:
        print(
            "Start Time \(newTimetableSlot.startTime) " +
            "End Time"
        )
        
        performSegue(withIdentifier: "addTaskCompletionSegue", sender: nil)
    }
    
    func pullSelectedDay() -> String { // Returns the week day that was selected in the weekDaySegmentControl
        var returnVal = ""
        if (weekDaySegmentControl.selectedSegmentIndex == 0) {
            returnVal = "Monday"
        }else if (weekDaySegmentControl.selectedSegmentIndex == 1) {
            returnVal = "Tuesday"
        }else if (weekDaySegmentControl.selectedSegmentIndex == 2) {
            returnVal = "Wednesday"
        }else if (weekDaySegmentControl.selectedSegmentIndex == 3) {
            return "Thurday"
        }else if (weekDaySegmentControl.selectedSegmentIndex == 4) {
            returnVal = "Friday"
        }else if (weekDaySegmentControl.selectedSegmentIndex == 5) {
            returnVal = "Saturday"
        }else if (weekDaySegmentControl.selectedSegmentIndex == 6) {
            returnVal = "Sunday"
        }
        return returnVal
    }
    
    func pullSelectedWeek() -> String { // Returns the week that was selected in the weekSegmentControl
        var returnVal = ""
        if (weekSegmentControl.selectedSegmentIndex == 0) {
            returnVal = "WeekA"
        }else if (weekSegmentControl.selectedSegmentIndex == 1) {
            returnVal = "WeekB"
        }
        return returnVal
    }
    
    func pullTimes(startTime: Bool) -> String { // Returns the time that was created in the time date picker view.
        var returnVal = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if (startTime == true) {
            returnVal = dateFormatter.string(from: startTimeDatePicker.date)
        }else if (startTime == false) {
            returnVal = dateFormatter.string(from: endTimeDatePicker.date)
        }
        return returnVal
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddTaskCompletionViewController
        nextVC.newTimetableSlot = newTimetableSlot
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
