//
//  MyCollectonView.swift
//  51Bang_ios_2016
//
//  Created by ios on 16/7/19.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class MyCollectionView: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var mTableview = UITableView()
    let topView = UIView()
    var Source:[BookDanDataModel] = []
    let rect = UIApplication.sharedApplication().statusBarFrame
    override func viewDidLoad() {
        
        let da = BookDanDataModel()
        da.DshowImage = UIImage.init(named: "01")!
        da.Dflag = 5
        da.DPrice = "123"
        da.DtitleLabel = "哈哈哈海鲜自助"
        da.DtipLabel = "在注册呢"
        da.DStatue = "待评价"
        da.DDistance = "15"
       Source = [da,da,da,da,da,da,da,da,da,da,da,da,da]
        self.navigationController?.navigationBar.hidden = false
        self.view.backgroundColor = RGREY
        super.viewDidLoad()
        mTableview = UITableView.init(frame: CGRectMake(0, 0, WIDTH, self.view.frame.size.height - rect.height )
            , style: UITableViewStyle.Grouped)
        mTableview.delegate = self
        mTableview.dataSource  = self
        self.view.addSubview(mTableview)
        self.title = "我的收藏"
        topView.frame = CGRectMake(0, 0, WIDTH, 40)
        self.view.addSubview(topView)
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
