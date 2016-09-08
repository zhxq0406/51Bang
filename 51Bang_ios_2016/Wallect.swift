//
//  MoneyPack.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/21.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import Foundation
class Wallect: UIViewController {
    private let statuFrame = UIApplication.sharedApplication().statusBarFrame
    private let TopView = UIView()
    private let leftMoney = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGREY
        setTopView()
    }
    
    func setTopView()
    {
        TopView.frame = CGRectMake(0, 0, WIDTH, 180)
        TopView.backgroundColor = COLOR
        self.view.addSubview(TopView)
        let TitileLabel = UILabel()
        
        
        let BackButton = UIButton.init(frame: CGRectMake(5, statuFrame.height + 10, 20,20 ))
        BackButton.setImage(UIImage.init(named: "ic_fanhui-left"), forState: UIControlState.Normal)
        BackButton.setImage(UIImage.init(named: "ic_fanhui-left"), forState: UIControlState.Selected)
        BackButton.addTarget(self, action: #selector(self.backAction), forControlEvents: UIControlEvents.TouchUpInside)
        TopView.addSubview(BackButton)
        
        TitileLabel.text = "钱包"
        TitileLabel.frame = CGRectMake(WIDTH / 2 - 50, statuFrame.height + 10 , 100, 30)
        TitileLabel.textColor = UIColor.whiteColor()
        TitileLabel.adjustsFontSizeToFitWidth = true
        TitileLabel.textAlignment = NSTextAlignment.Center
        TopView.addSubview(TitileLabel)
        
        let dayTip = UILabel()
        dayTip.frame = CGRectMake(5, statuFrame.height + 40 + 70 + 10, 100, 30)
        dayTip.text = "账户余额"
        dayTip.textColor = UIColor.whiteColor()
        dayTip.adjustsFontSizeToFitWidth  = true
        dayTip.font = UIFont.systemFontOfSize(15)
        TopView.addSubview(dayTip)
        
        leftMoney.frame = CGRectMake(5, statuFrame.height + 40 + 10, WIDTH - 5, 60)
        leftMoney.text = "100.00"
        leftMoney.textColor = UIColor.whiteColor()
        leftMoney.textAlignment = NSTextAlignment.Left
        leftMoney.font = UIFont.systemFontOfSize(35)
        TopView.addSubview(leftMoney)
    }
    
    
    func backAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
}