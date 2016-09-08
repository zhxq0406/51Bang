//
//  DianDaoView.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/20.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
class QianDao: UIViewController {
    private let statuFrame = UIApplication.sharedApplication().statusBarFrame
    private let TopView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopView()
        self.view.backgroundColor = RGREY
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
        
        
        TitileLabel.text = "我的积分"
        TitileLabel.frame = CGRectMake(WIDTH / 2 - 50, statuFrame.height + 10 , 100, 30)
        TitileLabel.textColor = UIColor.whiteColor()
        TitileLabel.adjustsFontSizeToFitWidth = true
        TitileLabel.textAlignment = NSTextAlignment.Center
        TopView.addSubview(TitileLabel)
        
        
        let score = UILabel()
        
        score.frame = CGRectMake( WIDTH / 2 - 33 , statuFrame.height + 40 + 10, 66, 66)
        score.text = "517分"
        score.textColor = UIColor.whiteColor()
        score.backgroundColor = UIColor(red: 55 / 255 ,green: 225 / 255 ,blue: 209 / 255,alpha: 1)
        score.textAlignment = NSTextAlignment.Center
        score.font = UIFont.systemFontOfSize(17)
        score.layer.masksToBounds = true
        score.layer.cornerRadius = 33
        TopView.addSubview(score)
        
        let qian = UIButton()
        qian.frame = CGRectMake(WIDTH / 2 - 40,statuFrame.height + 40 + 70 + 10, 80, 30 )
        qian.setTitle("签到", forState: UIControlState.Normal)
        qian.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        qian.layer.borderWidth = 1
        qian.layer.cornerRadius = 15
        qian.layer.borderColor = UIColor.whiteColor().CGColor
        qian.layer.masksToBounds = true
        
        TopView.addSubview(qian)

    }
    
    
    func backAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
