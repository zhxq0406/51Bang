//
//  CollectionTableViewCell.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/14.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    

    @IBOutlet weak var iconImage: UIImageView!
    
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var desc: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var buy: UIButton!
    
    
    @IBOutlet weak var distance: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buy.layer.borderWidth = 1
        self.buy.layer.borderColor = UIColor.orangeColor().CGColor
        self.buy.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.buy.layer.cornerRadius = 5
        // Initialization code
    }

    func setValueWithInfo(info:CollectionInfo){
    
        self.title.text = info.title
        self.desc.text = info.description
    
    
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
