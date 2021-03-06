//
//  MyBookDan.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class BookDanDataModel {
    var  DshowImage = UIImage()
    var  DtitleLabel = ""
    var  DtipLabel = ""
    var  DPrice = ""
    var  DStatue = ""
    var  DBtn = UIButton()
    var  DDistance = ""
    var  Dflag = 1
}

class MyBookDan: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var mTableview = UITableView()
    let topView = UIView()
    let allBtn = UIButton()
    let willPayBtn = UIButton()
    let willUserBtn = UIButton()
    let willCommentBtn = UIButton()
    let deView = UIView()
    var Data:[BookDanDataModel] = []
    var Data2:[BookDanDataModel] = []
    var Data3:[BookDanDataModel] = []
    var Data4:[BookDanDataModel] = []
    var Source:[BookDanDataModel] = []
    let rect = UIApplication.sharedApplication().statusBarFrame
    override func viewDidLoad() {
        
        let da = BookDanDataModel()
        da.DshowImage = UIImage.init(named: "01")!
        da.Dflag = 1
        da.DPrice = "123"
        da.DtitleLabel = "哈哈哈海鲜自助"
        da.DtipLabel = "在注册呢"
        da.DStatue = "待评价"
        let da1 = BookDanDataModel()
        da1.DshowImage = UIImage.init(named: "01")!
        da1.Dflag = 2
        da1.DPrice = "123"
        da1.DtitleLabel = "哈哈哈海鲜自助"
        da1.DtipLabel = "在注册呢"
        da1.DStatue = "待付款"
        
        let da2 = BookDanDataModel()
        da2.DshowImage = UIImage.init(named: "01")!
        da2.Dflag = 3
        da2.DPrice = "123"
        da2.DtitleLabel = "哈哈哈海鲜自助"
        da2.DtipLabel = "在注册呢"
        da2.DStatue = "待评价"
        
        let da3 = BookDanDataModel()
        da3.DshowImage = UIImage.init(named: "01")!
        da3.Dflag = 4
        da3.DPrice = "123"
        da3.DtitleLabel = "哈哈哈海鲜自助"
        da3.DtipLabel = "在注册呢"
        da3.DStatue = "待评价"
        
        
        
        Data = [da,da1,da2,da3,da2,da3,da3,da,da,da,da]
        Data2 = [da1,da1]
        Data3 = [da2,da2,da2]
        Data4 = [da3]
        
        self.navigationController?.navigationBar.hidden = false
        self.view.backgroundColor = RGREY
        super.viewDidLoad()
        mTableview = UITableView.init(frame: CGRectMake(0, 45, WIDTH, self.view.frame.size.height - 45.1 - rect.height )
            , style: UITableViewStyle.Grouped)
        mTableview.delegate = self
        mTableview.dataSource  = self
        self.view.addSubview(mTableview)
        self.title = "我的订单"
        topView.frame = CGRectMake(0, 0, WIDTH, 40)
        self.view.addSubview(topView)
        deView.frame = CGRectMake(0, 35, WIDTH / 4, 5)
        deView.backgroundColor = COLOR
        topView.backgroundColor = UIColor.whiteColor()
        topView.addSubview(deView)
        setBtn()
        
        Source = Data
        
        
    }
    
    func setBtn()
    {
        allBtn.frame = CGRectMake(0, 0, WIDTH / 4, 35)
        willPayBtn.frame = CGRectMake( WIDTH / 4, 0, WIDTH / 4, 35)
        willUserBtn.frame = CGRectMake(WIDTH * 2 / 4, 0, WIDTH / 4, 35)
        willCommentBtn.frame = CGRectMake(WIDTH * 3 / 4, 0, WIDTH / 4, 35)
        allBtn.setTitle("全部", forState: UIControlState.Normal)
        willPayBtn.setTitle("待付款", forState: UIControlState.Normal)
        willUserBtn.setTitle("待消费", forState: UIControlState.Normal)
        willCommentBtn.setTitle("待评价", forState: UIControlState.Normal)
        allBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
        willPayBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        willUserBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        willCommentBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        allBtn.addTarget(self, action: #selector(self.changeColorAndDeView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        willPayBtn.addTarget(self, action: #selector(self.changeColorAndDeView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        willUserBtn.addTarget(self, action: #selector(self.changeColorAndDeView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        willCommentBtn.addTarget(self, action: #selector(self.changeColorAndDeView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        allBtn.tag = 1
        willPayBtn.tag = 2
        willUserBtn.tag  = 3
        willCommentBtn.tag = 4
        topView.addSubview(allBtn)
        topView.addSubview(willPayBtn)
        topView.addSubview(willUserBtn)
        topView.addSubview(willCommentBtn)
        
    }
    
    func changeColorAndDeView(Btn:UIButton)
    {
        switch Btn.tag {
        case 1:
            allBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
            willPayBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willUserBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willCommentBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            deView.frame = CGRectMake(0, 35, WIDTH / 4, 5)
            Source = Data
            
        case 2:
            allBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willPayBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
            willUserBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willCommentBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            deView.frame = CGRectMake(WIDTH / 4, 35, WIDTH / 4, 5)
            Source = Data2
            
        case 3:
            allBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willPayBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willUserBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
            willCommentBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            deView.frame = CGRectMake(WIDTH  * 2 / 4, 35, WIDTH / 4, 5)
            Source = Data3
            
        default:
            allBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willPayBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willUserBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            willCommentBtn.setTitleColor(COLOR, forState: UIControlState.Normal)
            deView.frame = CGRectMake(WIDTH  * 3 / 4, 35, WIDTH / 4, 5)
            Source = Data4
            
            
        }
        
        mTableview.reloadData()
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Source.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return MyBookDanCell.init(Data: Source[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
