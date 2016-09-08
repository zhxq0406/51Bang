//
//  ShopTableViewCell.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import SDWebImage

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var myimage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var context: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var sales: UILabel!
    
 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setValueWithModel(goodsInfo:GoodsInfo){
    
        self.title.text = goodsInfo.goodsname
        self.context.text = goodsInfo.description
        self.distance.text = "现在没有"
        self.oldPrice.text = goodsInfo.price
        self.price.text = goodsInfo.price
        self.sales.text = "已售0"
        print(goodsInfo.picture)
        print(goodsInfo.goodsname)
        if goodsInfo.picture == "" {
            
            self.myimage.image = UIImage(named: ("01"))
        }else{
            let photoUrl:String = "http://bang.xiaocool.net/uploads/images/"+goodsInfo.picture!
            print(photoUrl)
            //http://bang.xiaocool.net./data/product_img/4.JPG
            //self.myimage.setImage("01"), forState: UIControlState.Normal)
            //        self.myimage.image =
            self.myimage.sd_setImageWithURL(NSURL(string:photoUrl), placeholderImage: UIImage(named: "1.png"))
        }
        
    
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
