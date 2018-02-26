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
        
        completeTaskButton.layer.cornerRadius = 10
        completeTaskButton.backgroundColor = UIColor.white
    }
    
    @IBAction func taskCompleted(_ sender: Any) {
    /*
        print("Button pressed")
    
        let userUID = Auth.auth().currentUser!.uid
        Database.database().reference().child("users").child(userUID).child("tasks").child(associatedTask.key).removeValue { (error, ref) in
            if (error != nil) {
                print("Cannot remove")
            }else{
                print("Successfully removed task")
                
                UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                    self.cellSubView.alpha = 0
                    self.taskNameLabel.alpha = 0
                    self.expandedSubView.alpha = 0
                    self.expandedSubView.frame.size.height = 0
                    self.expandedSubSubView.alpha = 0
                    self.expandedSubSubView.frame.size.height = 0
                    self.completeTaskButton.alpha = 0
                    self.completeByLabel.alpha = 0
                }, completion: { (done) in
                    print("Animation Complete")
                })
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }*/
    }
}

