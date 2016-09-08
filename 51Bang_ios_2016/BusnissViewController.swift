//
//  BusnissViewController.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

var isFavorite = Bool()
class BusnissViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var goodsInfo = GoodsInfo()
    let myTableView = UITableView()
    let  shopHelper = ShopHelper()
    var headerView = ShopHeaderViewCell()
    override func viewWillAppear(animated: Bool) {
        
        self.view.backgroundColor = RGREY
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = true
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
        self.myTableView.frame = CGRectMake(0, -20, WIDTH, HEIGHT)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.backgroundColor = RGREY
        self.myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.myTableView.registerNib(UINib(nibName:"EditTableViewCell2",bundle:nil), forCellReuseIdentifier: "cell2")
        myTableView.registerNib(UINib(nibName: "SiteTableViewCell",bundle: nil), forCellReuseIdentifier: "site")
        
        headerView =  (NSBundle.mainBundle().loadNibNamed("ShopHeaderViewCell", owner: nil, options: nil).first as? ShopHeaderViewCell)!
        headerView.favorite.addTarget(self, action: #selector(self.favorite), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.favorite.tag = 10
        print(isFavorite)
        if loginSign == 1 {
            
            let ud = NSUserDefaults.standardUserDefaults()
            let uid = ud.objectForKey("userid")as! String
            let shoucang = ud.objectForKey(uid)
            print(shoucang)
            if shoucang == nil {
                print("sdf")
            }
            if shoucang != nil && shoucang as! Bool == true {
                headerView.favorite.setImage(UIImage(named: "ic_yishoucang"), forState: UIControlState.Normal)
                isFavorite = true
            }else{
                headerView.favorite.setImage(UIImage(named: "ic_weishoucang"), forState: UIControlState.Normal)
                isFavorite = false
            }
            //
        }else{
            headerView.favorite.setImage(UIImage(named: "ic_weishoucang"), forState: UIControlState.Normal)
            
        }
        
        
        headerView.frame = CGRectMake(0, 0, WIDTH, WIDTH*350/375)
        myTableView.tableHeaderView = headerView
        headerView.back.addTarget(self, action: #selector(click), forControlEvents: UIControlEvents.TouchUpInside)
        let footView = NSBundle.mainBundle().loadNibNamed("ShopFootViewCell", owner: nil, options: nil).first as? ShopFootViewCell
        footView?.buy.addTarget(self, action: #selector(self.orderList), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        myTableView.tableFooterView = footView
        //        myTableView.tableFooterView?.frame.size.height = WIDTH*50/375
        footView?.frame = CGRectMake(0, HEIGHT-WIDTH*50/375, WIDTH, WIDTH*50/375)
        self.view.addSubview(myTableView)
        self.view.addSubview(footView!)
    }
    
    func orderList(){
    
        let vc = AffirmOrderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    
    func click(){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createLeftNavi(){
        
        let button = UIButton()
        button.frame = CGRectMake(10, 40, 20, 20)
        button.backgroundColor = UIColor.redColor()
        //        let item = UIBarButtonItem(customView:button)
        self.myTableView.addSubview(button)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        if tableView.tag == 0 {
        if indexPath.row == 0 {
            return 80
        }else{
            
            return 60
        }
        
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.myTableView.separatorStyle = .None
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("site")as! SiteTableViewCell
            
            cell.selectionStyle = .None
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2")as!EditTableViewCell2
            cell.title.text = "我的发布"
            cell.selectionStyle = .None
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        isFavorite = false
        self.view.backgroundColor = RGREY
        
        // Do any additional setup after loading the view.
    }
    
    func myfabu(){
        
        let vc = MenuViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row != 0)
        {
            self.myfabu()
        }
    }
    
    //收藏
    func favorite(){
        
        print(loginSign)
        if loginSign == 0 {
            
            self.tabBarController?.selectedIndex = 3
            
        }else{
            
            
            print("收藏商品")
            print(isFavorite)
            let ud = NSUserDefaults.standardUserDefaults()
            let uid = ud.objectForKey("userid")as! String
            print(uid)
            if isFavorite == false {
                
                shopHelper.favorite(uid, type: "3", goodsid: self.goodsInfo.id!, title: self.goodsInfo.goodsname!, desc: self.goodsInfo.description!) { (success, response) in
                    
                    print(response)
                    let button = self.view.viewWithTag(10)as! UIButton
                    button.setImage(UIImage(named: "ic_yishoucang"), forState: UIControlState.Normal)
                    isFavorite = true
                    ud.setObject(isFavorite, forKey: uid)
                }
            }else{
                
                //取消收藏
                shopHelper.cancelFavoritefunc(uid, type: "3", goodsid: self.goodsInfo.id!, handle: { (success, response) in
                    print(response)
                    let button = self.view.viewWithTag(10)as! UIButton
                    button.setImage(UIImage(named: "ic_weishoucang"), forState: UIControlState.Normal)
                    isFavorite = false
                    ud.setObject(isFavorite, forKey: uid)
                })
                
            }
            
        }
        //
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
