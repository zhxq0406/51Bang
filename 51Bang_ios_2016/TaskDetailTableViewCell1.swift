//
//  TaskDetailTableViewCell1.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/5.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class TaskDetailTableViewCell1: UITableViewCell {

    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bottomView.backgroundColor = RGREY
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}