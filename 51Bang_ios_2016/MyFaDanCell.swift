//
//  MyFaDanCell.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/15.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class MyFaDanCell: UITableViewCell {
    
    
    private let taskStatu = UILabel()
    private let Middle = UIView()
    private let Bottom = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(module:DanModel){
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "MyFaDanCell")
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.clearColor()
        
        Middle.frame = CGRectMake(0, 45, WIDTH, 120)
        Bottom.frame = CGRectMake(0, 170, WIDTH, 40)
        taskStatu.backgroundColor = UIColor.whiteColor()
        Middle.backgroundColor = UIColor.whiteColor()
        Bottom.backgroundColor = UIColor.whiteColor()
        self.addSubview(taskStatu)
        self.addSubview(Middle)
        self.addSubview(Bottom)
        setTop()
        setMiddle(module.taskid, Name: module.taskName, sMen: module.taskMan, reMen: module.receive)
        setBottom(module.statuMoney)
        
    }
    
    
    func setTop()
    {
        taskStatu.text = " "+"未完成"
        taskStatu.textColor = UIColor.orangeColor()
        taskStatu.frame = CGRectMake(0, 0,WIDTH, 40)
        self.addSubview(taskStatu)
        
    }
    
    func setMiddle(Num:String,Name:String,sMen:String,reMen:String)
    {
        let taskNum = UILabel()
        taskNum.text = " 任务号："+Num
        taskNum.frame = CGRectMake(0, 0, WIDTH, 40)
        Middle.addSubview(taskNum)
        let taskName = UILabel()
        taskName.text = " " + Name
        taskName.frame = CGRectMake(0, 40, WIDTH, 40)
        Middle.addSubview(taskName)
        let startMen = UILabel()
        startMen.text = " 发起人:"
        startMen.adjustsFontSizeToFitWidth = true
        startMen.frame = CGRectMake(0, 80, WIDTH / 4 - 30, 40)
        Middle.addSubview(startMen)
        let smenNum = UILabel()
        smenNum.text = sMen
        smenNum.frame = CGRectMake(WIDTH / 4 - 30, 80, WIDTH / 4 + 30, 40)
        smenNum.textColor = UIColor.blueColor()
        smenNum.adjustsFontSizeToFitWidth = true
        Middle.addSubview(smenNum)
        let receiveMen = UILabel()
        receiveMen.text = "接单人"
        receiveMen.adjustsFontSizeToFitWidth = true
        receiveMen.frame = CGRectMake(WIDTH * 2 / 4, 80, WIDTH / 4 - 30, 40)
        Middle.addSubview(receiveMen)
        let rmenNum = UILabel()
        rmenNum.text = reMen
        rmenNum.frame = CGRectMake(WIDTH * 3  / 4 - 30, 80, WIDTH / 4 + 30, 40)
        rmenNum.textColor = UIColor.blueColor()
        rmenNum.adjustsFontSizeToFitWidth = true
        Middle.addSubview(rmenNum)
        
    }
    
    func setBottom(Money:String)
    {
        
        let payMoney = UILabel()
        payMoney.text = " 支付状态："+Money
        payMoney.frame = CGRectMake(0, 0, 130, 40)
        let Tip = UILabel()
        Tip.text = "未完成（请确认付款）"
        Tip.textColor = UIColor.orangeColor()
        Tip.adjustsFontSizeToFitWidth = true
        Tip.frame = CGRectMake(130, 0, 130, 40)
        Bottom.addSubview(Tip)
        let payBtn = UIButton()
        payBtn.frame = CGRectMake(WIDTH - 60, 5,50 , 30)
        payBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        payBtn.setTitle("确认付款", forState: UIControlState.Normal)
        payBtn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        payBtn.layer.cornerRadius = 10
        payBtn.layer.borderWidth = 1
        payBtn.layer.masksToBounds = true
        payBtn.layer.borderColor = UIColor.orangeColor().CGColor
        Bottom.addSubview(payBtn)
        Bottom.addSubview(payMoney)
    
    }
}
