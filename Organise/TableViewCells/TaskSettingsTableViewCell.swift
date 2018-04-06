//
//  TaskSettingsTableViewCell.swift
//  Organise
//
//  Created by Thomas Houghton on 26/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class TaskSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingTitleLabel: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var expandedSubview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        subView.layer.cornerRadius = 10
        expandedSubview.layer.cornerRadius = 10
    }
}












