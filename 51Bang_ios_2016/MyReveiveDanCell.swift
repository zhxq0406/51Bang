//
//  ReveiveCell.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/19.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class MyReceiveDanCell: UITableViewCell{
    let topView = UIView()
    let middleView = UIView()
    let bottomView = UIView()
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    
    init(Data:ReceveModel)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "MyReceiveDanCell")
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        topView.frame = CGRectMake(0, 0, WIDTH, 40)
        middleView.frame = CGRectMake(0, 45, WIDTH, 90)
        bottomView.frame = CGRectMake(0, 140, WIDTH, 50)
        self.addSubview(topView)
        self.addSubview(middleView)
        self.addSubview(bottomView)
        
        let timLabel = UILabel.init(frame: CGRectMake(WIDTH - 100, 0, 95, 40))
        timLabel.textColor = UIColor.grayColor()
        timLabel.adjustsFontSizeToFitWidth = true
        timLabel.text = Data.taskTime
        topView.addSubview(timLabel)
        let taNum = UILabel.init(frame: CGRectMake(0, 0, WIDTH - 100 , 40))
        taNum.text = " 订单号" + Data.taskNum
        topView.addSubview(taNum)
        
        let taName = UILabel.init(frame: CGRectMake(0, 0, WIDTH, 30))
        taName.text = " " + Data.taskName
        taName.textColor = UIColor.grayColor()
        middleView.addSubview(taName)
        
        let addImage = UIImageView()
        addImage.image = UIImage.init(named: "ic_fuwudidian")
        addImage.frame = CGRectMake(5, 35, 15,15)
        middleView.addSubview(addImage)
        
        let addressLabel = UILabel()
        addressLabel.text = Data.adressName
        addressLabel.textColor = UIColor.grayColor()
        addressLabel.frame = CGRectMake(35, 30, WIDTH - 35, 30)
        middleView.addSubview(addressLabel)
        
        let fuwuPay = UILabel.init(frame: CGRectMake(0, 0, 100, 20))
        fuwuPay.text = " 服务费"
        fuwuPay.textColor = UIColor.grayColor()
        fuwuPay.textAlignment = NSTextAlignment.Left
        bottomView.addSubview(fuwuPay)
        
        
        let Price = UILabel.init(frame: CGRectMake(0, 20, 100, 30))
        Price.text = " ￥" + Data.Price
        Price.textColor = UIColor.redColor()
        Price.textAlignment = NSTextAlignment.Left
        Price.adjustsFontSizeToFitWidth = true
        bottomView.addSubview(Price)
        
        let tipStatue = UILabel.init(frame: CGRectMake(130, 0, 100, 20))
        tipStatue.text = "支付类型"
        tipStatue.textColor  = UIColor.grayColor()
        bottomView.addSubview(tipStatue)
        
        let KindPay = UILabel.init(frame: CGRectMake(130, 20, 100, 30))
        KindPay.text = Data.payWay
        KindPay.textColor = UIColor.orangeColor()
        KindPay.adjustsFontSizeToFitWidth = true
        bottomView.addSubview(KindPay)
        
        
        if(Data.flag == 1)
        {
            let Btn = UIButton()
            Btn.setTitle("立即接单", forState: UIControlState.Normal)
            Btn.layer.borderColor = COLOR.CGColor
            Btn.setTitleColor(COLOR, forState: UIControlState.Normal)
            Btn.layer.cornerRadius = 10
            Btn.layer.borderWidth = 1
            Btn.layer.masksToBounds = true
            Btn.frame = CGRectMake(WIDTH - 70, 15, 60, 30)
            Btn.titleLabel?.font = UIFont.systemFontOfSize(11)
            bottomView.addSubview(Btn)
        }else{
        
            let stat = UILabel.init(frame: CGRectMake(WIDTH - 50, 0, 45, 20))
            stat.text = "订单状态"
            stat.textColor = UIColor.grayColor()
            stat.textAlignment  = NSTextAlignment.Left
            stat.adjustsFontSizeToFitWidth = true
            bottomView.addSubview(stat)
            let ST = UILabel.init(frame: CGRectMake(WIDTH - 50, 20,45, 30))
            ST.textColor = COLOR
            ST.text = Data.taskStatue
            ST.adjustsFontSizeToFitWidth = true
            bottomView.addSubview(ST)
        }
        
    
    }
    
}
