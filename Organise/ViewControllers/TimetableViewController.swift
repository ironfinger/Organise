//
//  TimetableViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 01/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var timetableSlots:[String] = []
    
    // MARK: View Setup:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self // Declare the datasource of the table view.
        self.tableView.delegate = self // Declare the delegate of the table view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Set Up Array")
        timetableSlots.append("Test Cell")
        tableView.reloadData()
    }
    
    // MARK: Table View:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetableSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = timetableSlots[indexPath.row]
        return cell
    }
    
    // MARK: Actions:
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addTimetableSlotSegue", sender: nil)
    }
    
    // MARK: Segue:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddTaskViewController
        nextVC.addType = "Timetable"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
