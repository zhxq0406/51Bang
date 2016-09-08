//
//  MyInsure.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/20.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
class MyInsure: UIViewController {
    private let Nav = UIView()
    private let Statue = UILabel()
    private let TopView = UIView()
    private let InsureBtn = UIButton()
    private let statuFrame = UIApplication.sharedApplication().statusBarFrame

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGREY
        setTopView()
        setBtutton()
    }
    
    
    func setTopView()
    {
    
        TopView.frame = CGRectMake(0, 0, WIDTH, 170)
        TopView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(TopView)
        
        Nav.frame = CGRectMake(0, 0, WIDTH, statuFrame.height + 40)
        TopView.addSubview(Nav)
        Nav.backgroundColor = COLOR
        
        let BackButton = UIButton.init(frame: CGRectMake(5, statuFrame.height + 10, 20,20 ))
        BackButton.setImage(UIImage.init(named: "ic_fanhui-left"), forState: UIControlState.Normal)
        BackButton.setImage(UIImage.init(named: "ic_fanhui-left"), forState: UIControlState.Selected)
        BackButton.addTarget(self, action: #selector(self.backAction), forControlEvents: UIControlEvents.TouchUpInside)
        Nav.addSubview(BackButton)
        
        
        let TitileLabel = UILabel()
        TitileLabel.text = "服务保障"
        TitileLabel.frame = CGRectMake(WIDTH / 2 - 50, statuFrame.height + 10 , 100, 30)
        TitileLabel.textColor = UIColor.whiteColor()
        TitileLabel.adjustsFontSizeToFitWidth = true
        TitileLabel.textAlignment = NSTextAlignment.Center
        Nav.addSubview(TitileLabel)
        
        
        
        Statue.frame = CGRectMake( WIDTH / 2 - 50 , statuFrame.height + 40 + 10, 100, 60)
        Statue.text = "未投保"
        Statue.textColor = UIColor.whiteColor()
        Statue.textAlignment = NSTextAlignment.Center
        Statue.font = UIFont.systemFontOfSize(32)
        TopView.addSubview(Statue)
        
        
        let Tip = UILabel()
        Tip.frame = CGRectMake(WIDTH / 2 - 40,statuFrame.height + 40 + 70 + 10, 80, 30 )
        Tip.text = "今日保障状态"
        Tip.textColor = UIColor.whiteColor()
        Tip.adjustsFontSizeToFitWidth  = true
        Tip.textAlignment = NSTextAlignment.Center
        Tip.font = UIFont.systemFontOfSize(15)
        TopView.addSubview(Tip)

        
    }
    
    
    func backAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setBtutton()
    {
        InsureBtn.frame = CGRectMake(10, 180, WIDTH - 20, 40)
        InsureBtn.setTitle("10元/投保", forState: UIControlState.Normal)
        InsureBtn.backgroundColor = COLOR
        InsureBtn.setTitleShadowColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        InsureBtn.addTarget(self, action: #selector(self.InsureAction), forControlEvents: UIControlEvents.TouchUpInside)
        InsureBtn.layer.masksToBounds = true
        InsureBtn.layer.cornerRadius = 10
        self.view.addSubview(InsureBtn)
    }
    
    func InsureAction()
    {
        InsureBtn.backgroundColor = UIColor.grayColor()
        TopView.backgroundColor = COLOR
        Statue.text = "已投保"
    }

}
