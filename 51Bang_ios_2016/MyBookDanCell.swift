//
//  MyBookDanCell.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
class MyBookDanCell: UITableViewCell {
    let  showImage = UIImageView()
    let  titleLabel = UILabel()
    let  tipLabel = UILabel()
    let  Price = UILabel()
    let  Statue = UILabel()
    let  Btn = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(Data:BookDanDataModel)
    {
        super.init(style: UITableViewCellStyle.Default
            , reuseIdentifier: "MyBookDanCell")
        self.selectionStyle = UITableViewCellSelectionStyle.None
        setLayout(Data)
        
        
    }
    
    func setLayout(Data:BookDanDataModel)
    {
        
        showImage.frame = CGRectMake(5, 5, 100, 90)
        showImage.image = Data.DshowImage
        self.addSubview(showImage)
        
        Statue.frame = CGRectMake(WIDTH - 50, 5, 45, 30)
        self.addSubview(Statue)
        Statue.adjustsFontSizeToFitWidth = true
        
        if(Data.Dflag == 5)
        {
            Statue.textColor = UIColor.grayColor()
            Statue.text = Data.DDistance + "Km"//重用此Cell让状态改为距离用于我收藏界面
        
        }else{
        Statue.textColor = COLOR
        Statue.text = Data.DStatue
        }
        
        
        
        titleLabel.frame = CGRectMake(showImage.frame.origin.x + 105, 5, WIDTH - (showImage.frame.origin.x + 105) - Statue.frame.width - 10, 30)
        self.addSubview(titleLabel)
        titleLabel.text = Data.DtitleLabel
        
        tipLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + 30, WIDTH - titleLabel.frame.origin.x , 30)
        
        tipLabel.text = Data.DtipLabel
        self.addSubview(tipLabel)
        
        
        Btn.frame = CGRectMake(WIDTH - 50, tipLabel.frame.origin.y + 30, 45, 30)
        self.addSubview(Btn)
        Btn.layer.cornerRadius = 10
        Btn.layer.masksToBounds = true
        Btn.layer.borderWidth = 1
        Btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        Btn.layer.borderColor = UIColor.orangeColor().CGColor
        Btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        
        Price.frame = CGRectMake(titleLabel.frame.origin.x,  tipLabel.frame.origin.y + 30, 100, 30)
        Price.text = "￥" + Data.DPrice
        Price.textColor = UIColor.redColor()
        self.addSubview(Price)
        
        
        
        switch Data.Dflag {
        case 1:
            Btn.setTitle("评价", forState: UIControlState.Normal)
            
            Btn.addTarget(self, action: #selector(self.Comment), forControlEvents: UIControlEvents.TouchUpInside)
        case 2:
            Btn.setTitle("付款", forState: UIControlState.Normal)
            Btn.addTarget(self, action: #selector(self.Comment), forControlEvents: UIControlEvents.TouchUpInside)
        case 3:
            Btn.hidden = true
        case 4:
            Btn.setTitle("取消订单", forState: UIControlState.Normal)
            
            Btn.addTarget(self, action: #selector(self.Comment), forControlEvents: UIControlEvents.TouchUpInside)
            let btnFrame = Btn.frame
            Btn.frame = CGRectMake(btnFrame.origin.x - 20,btnFrame.origin.y, 70, 30)
        case 5:
            Btn.setTitle("立即购买", forState: UIControlState.Normal)
            
            Btn.addTarget(self, action: #selector(self.imdiaBuy), forControlEvents: UIControlEvents.TouchUpInside)
            let btnFrame = Btn.frame
            Btn.frame = CGRectMake(btnFrame.origin.x - 20,btnFrame.origin.y, 70, 30)
            
        default:
            print("没有此button")
            
            
            
        }
        
        
        
    }
    
    func Comment()
    {
        print("评价")
    }
    
    func pay()
    {
        print("付款")
    }
    
    func Cancel()
    {
        print("取消订单")
    }
    
    
    func imdiaBuy()
    {
        print("立即购买")
    }
    
}
