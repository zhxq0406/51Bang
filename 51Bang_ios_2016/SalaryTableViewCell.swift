//
//  SalaryTableViewCell.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/1.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class SalaryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var mothed: UILabel!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
