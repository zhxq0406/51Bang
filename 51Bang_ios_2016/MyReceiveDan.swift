//
//  MyReceiveDan.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/19.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
class ReceveModel {
    var taskNum = ""
    var taskName = ""
    var adressName = ""
    var Price = ""
    var payWay = ""
    var taskTime = ""
    var taskStatue = ""
    var flag = 1
}
class MyReceiveDan: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    private let TopView = UIView()
    private let statuFrame = UIApplication.sharedApplication().statusBarFrame
    private var monthReceiveNum = "160"
    private var dayReceiveNum = "34"
    private let monthReceiveLabel = UILabel()
    private let dayReceiveLabel = UILabel()
    private var Datasource:[ReceveModel] = []
    private var mTable = UITableView()
    private let rect  = UIApplication.sharedApplication().statusBarFrame
    private let selectDate = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGREY
        setTopView()
        mTable = UITableView.init(frame: CGRectMake(0,  170, WIDTH,  self.view.frame.height -  170))
        mTable.delegate = self
        mTable.dataSource = self
        self.view.addSubview(mTable)
        let da = ReceveModel()
        da.taskNum = "wyb123456"
        da.taskName = "帮我跑腿帮我跑腿"
        da.adressName = "山东省  烟台市  芝罘区"
        da.Price = "10.00"
        da.payWay = "线下支付"
        da.taskTime = "06-07 10:30"
        da.taskStatue = "已完成"
        da.flag = 1
        
        
        
        
        let da1 = ReceveModel()
        da1.taskNum = "wyb123456"
        da1.taskName = "帮我跑腿帮我跑腿"
        da1.adressName = "山东省  烟台市  芝罘区"
        da1.Price = "10.00"
        da1.payWay = "线下支付"
        da1.taskTime = "06-07 10:30"
        da1.taskStatue = "已完成"
        da1.flag = 2
        Datasource = [da,da,da,da1,da1,da1,da1]
        
        
        
        
    }
    
    func setTopView()
    {
        
        TopView.frame = CGRectMake(0, 0, WIDTH, 170)
        TopView.backgroundColor = COLOR
        self.view.addSubview(TopView)

        
        selectDate.frame = CGRectMake(WIDTH - 25, statuFrame.height + 10, 20, 20)
        selectDate.setImage(UIImage.init(named: "ic_youxiaoqi"), forState: UIControlState.Normal)
        selectDate.addTarget(self, action: #selector(self.selectDateAction), forControlEvents: UIControlEvents.TouchUpInside)
        TopView.addSubview(selectDate)
        
        
        
        
        
        
        let BackButton = UIButton.init(frame: CGRectMake(5, statuFrame.height + 10, 20,20 ))
        BackButton.setImage(UIImage.init(named: "ic_fanhui-left"), forState: UIControlState.Normal)
        BackButton.setImage(UIImage.init(named: "ic_fanhui-left"), forState: UIControlState.Selected)
        BackButton.addTarget(self, action: #selector(self.backAction), forControlEvents: UIControlEvents.TouchUpInside)
        let TitileLabel = UILabel()
        TitileLabel.text = "我的接单"
        TitileLabel.frame = CGRectMake(WIDTH / 2 - 50, statuFrame.height + 10 , 100, 30)
        TitileLabel.textColor = UIColor.whiteColor()
        TitileLabel.adjustsFontSizeToFitWidth = true
        TitileLabel.textAlignment = NSTextAlignment.Center
        TopView.addSubview(TitileLabel)
        TopView.addSubview(BackButton)
        monthReceiveLabel.frame = CGRectMake( WIDTH / 2 - 50 , statuFrame.height + 40 + 10, 100, 60)
        monthReceiveLabel.text = monthReceiveNum
        monthReceiveLabel.textColor = UIColor.whiteColor()
        monthReceiveLabel.textAlignment = NSTextAlignment.Center
        monthReceiveLabel.font = UIFont.systemFontOfSize(35)
        TopView.addSubview(monthReceiveLabel)
        let monthTip = UILabel()
        monthTip.frame = CGRectMake(WIDTH / 2 - 40,statuFrame.height + 40 + 70 + 10, 80, 30 )
        monthTip.text = "本月接单"
        monthTip.textColor = UIColor.whiteColor()
        monthTip.adjustsFontSizeToFitWidth  = true
        monthTip.textAlignment = NSTextAlignment.Center
        monthTip.font = UIFont.systemFontOfSize(15)
        TopView.addSubview(monthTip)
        
        let dayTip = UILabel()
        dayTip.frame = CGRectMake(5, statuFrame.height + 40 + 70 + 10, 100, 30)
        dayTip.text = "今日接单"
        dayTip.textColor = UIColor.whiteColor()
        dayTip.adjustsFontSizeToFitWidth  = true
        dayTip.font = UIFont.systemFontOfSize(15)
        TopView.addSubview(dayTip)
        
        dayReceiveLabel.frame = CGRectMake(5, statuFrame.height + 40 + 10, 100, 60)
        dayReceiveLabel.text = dayReceiveNum
        dayReceiveLabel.textColor = UIColor.whiteColor()
        dayReceiveLabel.textAlignment = NSTextAlignment.Left
        dayReceiveLabel.font = UIFont.systemFontOfSize(35)
        TopView.addSubview(dayReceiveLabel)
        
    }
    
    func backAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func selectDateAction()
    {
        print("选择日期")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 3
        }else{
        return 4
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return MyReceiveDanCell.init(Data: Datasource[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0)
        {
            return "当前订单"
        }else
        {
            return "06-06"
        }
    }
    
    
}
