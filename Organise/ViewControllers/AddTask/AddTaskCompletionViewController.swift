//
//  AddTaskCompletionViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 02/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class AddTaskCompletionViewController: UIViewController {
    
    // Outlets:
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    // Variables:
    var newTimetableSlot = TimetableSlot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    // MARK: View setup.
    func setupView() {
        // Sub View:
        subView.layer.cornerRadius = 20
        // Add Task Button:
        addTaskButton.backgroundColor = UIColor.white
        addTaskButton.layer.cornerRadius = 10
        
        assignViewColors()
    }
    
    func assignViewColors() {
        let colorPallete = TaskColours()
        if (newTimetableSlot.color == "Default") {
            
        }else if (newTimetableSlot.color == "Red") {
            self.view.backgroundColor = colorPallete.red[0]
            self.subView.backgroundColor = colorPallete.red[1]
        }else if (newTimetableSlot.color == "Blue") {
            self.view.backgroundColor = colorPallete.blue[0]
            self.subView.backgroundColor = colorPallete.blue[1]
        }else if (newTimetableSlot.color == "Green") {
            self.view.backgroundColor = colorPallete.green[0]
            self.subView.backgroundColor = colorPallete.green[1]
        }else if (newTimetableSlot.color == "Purple") {
            self.view.backgroundColor = colorPallete.purple[0]
            self.subView.backgroundColor = colorPallete.purple[1]
        }
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "routeBackSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
