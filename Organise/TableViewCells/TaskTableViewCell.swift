//
//  TaskTableViewCell.swift
//  Organise
//
//  Created by Thomas Houghton on 23/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSubView: UIView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var expandedSubView: UIView!
    @IBOutlet weak var expandedSubSubView: UIView!
    @IBOutlet weak var completeTaskButton: UIButton!
    @IBOutlet weak var completeByLabel: UILabel!
    @IBOutlet weak var taskSettingsButton: UIButton!
    @IBOutlet weak var timeCompletion: UILabel!
    
    public let height = 91
    public let expandedHeight = 310
    var associatedTask = Task()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        cellSubView.layer.cornerRadius = 10
        expandedSubView.layer.cornerRadius = 10
        expandedSubSubView.layer.cornerRadius = 10
        timeCompletion.layer.cornerRadius = 10
        
        completeTaskButton.layer.cornerRadius = 10
        completeTaskButton.backgroundColor = UIColor.white
    }
    
    @IBAction func taskCompleted(_ sender: Any) {
    }
}

