//
//  TaskSettingViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 26/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class TaskSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets:
    @IBOutlet weak var tableView: UITableView!

    // Variables:
    let colors = TaskColours()
    
    var task = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeViewColors()
    }
    
    func changeViewColors() {
    
    }

    // MARK: TableView:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! TaskSettingsTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.subView.backgroundColor = colors.pullColorFromString(selectedColor: self.task.color, shade: 2)
        cell.expandedSubview.backgroundColor = colors.pullColorFromString(selectedColor: self.task.color, shade: 2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



















