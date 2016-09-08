//
//  MyFaDan.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/15.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
class DanModel {
    var taskid:String = ""
    var taskName:String = ""
    var taskMan:String = ""
    var receive:String = ""
    var statuMoney:String = ""
    
}
class MyFaDan: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //此处有bug
    var finshTable = UITableView()
    let weiBtn = UIButton()
    let finshBtn = UIButton()
    var cellData = DanModel()
    var Data = []
    var mTable = UITableView()
    let decorView = UIView()
    let rect  = UIApplication.sharedApplication().statusBarFrame
    override func viewDidLoad() {
        
        self.title = "我的发单"
        self.navigationController?.navigationBar.hidden = false
        decorView.frame = CGRectMake(0, 35, WIDTH / 2, 5)
        decorView.backgroundColor = COLOR
        self.view.addSubview(decorView)
        cellData.taskName="充公交卡"
        cellData.receive = "15589542081"
        cellData.statuMoney = "10元"
        cellData.taskid = "wyb123456"
        cellData.taskMan = "15589542081"
        Data = [cellData,cellData,cellData,cellData,cellData]
        mTable = UITableView.init(frame: CGRectMake(0, 40, WIDTH, self.view.frame.size.height - 45 - rect.height ), style: UITableViewStyle.Grouped)
        finshTable =  UITableView.init(frame: CGRectMake(0, 40, WIDTH, self.view.frame.size.height - 45 - rect.height), style: UITableViewStyle.Grouped)
        finshTable.hidden = true
        finshTable.delegate = self
        finshTable.dataSource = self
        self.view.addSubview(finshTable)
        self.view.addSubview(mTable)
        mTable.delegate = self
        mTable.dataSource = self
        mTable.tag = 0
        finshTable.tag = 1
        setButton()
        self.view.backgroundColor = RGREY
        
    }
    
    
    func setButton()
    {
        weiBtn.frame = CGRectMake(0, 0, WIDTH / 2, 35)
        finshBtn.frame  = CGRectMake(WIDTH / 2, 0, WIDTH / 2, 35)
        weiBtn.setTitle("未完成", forState: UIControlState.Normal)
        weiBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
        finshBtn.setTitle("已完成", forState: UIControlState.Normal)
        
        finshBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        finshBtn.addTarget(self, action: #selector(self.finshBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        weiBtn.addTarget(self, action: #selector(self.weiBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        weiBtn.backgroundColor = UIColor.whiteColor()
        finshBtn.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(weiBtn)
        self.view.addSubview(finshBtn)
        
    }
    
    
    
    func finshBtnAction()
    {
        
        weiBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        finshBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
        decorView.frame = CGRectMake( WIDTH / 2, 35, WIDTH / 2, 5)
        mTable.hidden = true
        finshTable.hidden = false
        
        
    }
    
    func weiBtnAction()
    {
        
        weiBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
        finshBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        decorView.frame = CGRectMake( 0, 35, WIDTH / 2, 5)
        mTable.hidden = false
        finshTable.hidden = true
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(tableView.tag == 0)
        {
            return Data.count
            
        }else{
            return Data.count
            
        }
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView.tag == 0)
        {
            return MyFaDanCell.init(module: Data[indexPath.section] as! DanModel)
        }else{
            return MyFaDanFinshCell.init(module: Data[indexPath.section] as! DanModel)
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 210
    }
    
}
