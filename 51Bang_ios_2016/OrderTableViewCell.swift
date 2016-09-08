//
//  OrderTableViewCell.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/6/28.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var snatchButton: UIButton!
    
    
    @IBOutlet weak var fuwudidian: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.topView.backgroundColor = RGREY
        self.leftView.backgroundColor = RGREY
        self.rightView.backgroundColor = RGREY
        // Initialization code
    }

    func setValueWithInfo(info:TaskInfo){
    
        self.title.text = info.title
        self.price.text = info.price
        self.desc.text = info.expirydate
        self.location.text = info.address
        self.fuwudidian.text = info.address
        self.username.text = info.name
        if info.time != "" {
            let str = timeStampToString(info.time!)
            self.time.text = str
            self.desc.text = str+"前有效"
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
