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
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addTaskCompletionSegue", sender: nil)
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
