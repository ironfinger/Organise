//
//  TasksViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 05/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    // Outlets:
    
    
    // Variables:
    
    
    // MARK: View setup.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: Actions.
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddTaskViewController", sender: nil)
    }
    
    
    // MARK: Segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddTaskViewController
        nextVC.addType = "Task"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
