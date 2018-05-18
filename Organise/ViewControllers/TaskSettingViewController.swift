//
//  TaskSettingViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 26/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TaskSettingViewController: UIViewController {
    
    // Outlets:
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    // Variables:
    let colors = TaskColours()
    
    var task = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subView.layer.cornerRadius = 10
        textView.layer.cornerRadius = 10
        datePickerView.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeViewColors()
        renderData()
        print("key: \(task.key)")
    }
    
    func changeViewColors() {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = self.colors.pullColorFromString(selectedColor: self.task.color, shade: 1)
            self.subView.backgroundColor = self.colors.pullColorFromString(selectedColor: self.task.color, shade: 2)
            self.textView.backgroundColor = self.colors.pullColorFromString(selectedColor: self.task.color, shade: 1)
            self.datePickerView.backgroundColor = self.colors.pullColorFromString(selectedColor: self.task.color, shade: 1)
        }
    }
    
    func renderData() {
        taskNameTextField.text = task.name
        textView.text = task.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.date(from: task.time)
        datePickerView.setDate(time!, animated: true)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let day = dateFormatter.date(from: task.day)
        datePickerView.setDate(day!, animated: true)
    }
    
    func data() {
        let userUID = Auth.auth().currentUser!.uid
        
        // Check to see for any changes:
        if (taskNameTextField.text != task.name) {
            Database.database().reference().child("users").child(userUID).child("tasks").child(task.key).updateChildValues(["taskName" : taskNameTextField.text!]) { (error, dataRef) in
                if (error != nil) {
                    print("We couldn't update the name of the task \(String(describing: error))")
                }else {
                    print("We successfully updated the name of the task")
                }
            }
        }
        
        if (textView.text != task.description) {
            Database.database().reference().child("users").child(userUID).child("tasks").child(task.key).updateChildValues(["description" : textView.text!]) { (error, dataRef) in
                if (error != nil) {
                    print("We couldn't update the name of the task \(error)")
                }else {
                    print("We successfully updated the name of the task")
                }
            }
        }
        
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.dateFormat = "yyyy-MM-dd"
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        
        let pickerTime = dateFormatterTime.string(from: datePickerView.date)
        let pickerDay = dateFormatterDay.string(from: datePickerView.date)
        
        if (pickerTime != task.time || pickerDay != task.day) {
            if (pickerTime != task.time) {
                Database.database().reference().child("users").child(userUID).child("tasks").child(task.key).updateChildValues(["time" : pickerTime]) { (error, dataRef) in
                    if (error != nil) {
                        print("We couldn't update the name of the task \(String(describing: error))")
                    }else {
                        print("We successfully updated the time of the task")
                    }
                }
                
                if (pickerDay != task.day) {
                    Database.database().reference().child("users").child(userUID).child("tasks").child(task.key).updateChildValues(["day" : pickerDay]) { (error, dataRef) in
                        if (error != nil) {
                            print("We couldn't update the name of the task \(String(describing: error))")
                        }else {
                            print("We successfully updated the day of the task")
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func viewTapped(_ sender: Any) {
        // Submit all data
        data()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
