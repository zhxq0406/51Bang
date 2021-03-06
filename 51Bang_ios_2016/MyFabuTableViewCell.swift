//
//  MyFabuTableViewCell.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/15.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import SDWebImage
class MyFabuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var sell: UILabel!
    
    @IBOutlet weak var delete: UIButton!
    
    @IBOutlet weak var edit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValueWithInfo(goodsInfo:GoodsInfo){
        
        self.title.text = goodsInfo.goodsname
        self.desc.text = goodsInfo.description
        self.distance.text = "现在没有"
        self.price.text = goodsInfo.price
        self.sell.text = "已售10"
        
        if goodsInfo.picture == "" {
            
            self.iconImage.image = UIImage(named: ("01"))
        }else{
            let photoUrl:String = "http://bang.xiaocool.net/uploads/images/"+goodsInfo.picture!
            print(photoUrl)
            //http://bang.xiaocool.net./data/product_img/4.JPG
            //self.myimage.setImage("01"), forState: UIControlState.Normal)
            //        self.myimage.image =
            self.iconImage.sd_setImageWithURL(NSURL(string:photoUrl), placeholderImage: UIImage(named: "1.png"))
        }

    
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
