//
//  MenuViewController.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let myTableView = UITableView()
    let  shopHelper = ShopHelper()
    var dataSource : Array<GoodsInfo>?
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "我的发布"
        self.view.backgroundColor = RGREY
        self.getData()
        
        // Do any additional setup after loading the view.
    }
    
    
    func getData(){
        
        if loginSign == 0 {
            
            self.tabBarController?.selectedIndex = 3
            
        }else{
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.animationType = .Zoom
            hud.labelText = "正在努力加载"
            let ud = NSUserDefaults.standardUserDefaults()
            let userid = ud.objectForKey("userid")as! String
            
            shopHelper.getMyFaBu(userid) { (success, response) in
                if !success {
                    return
                }
                hud.hide(true)
                print(response)
                self.dataSource = response as? Array<GoodsInfo> ?? []
                print(self.dataSource)
                print(self.dataSource?.count)
                self.createTableView()
            }
        }
        
    }
    
    func createTableView(){
        self.myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.backgroundColor = RGREY
        self.myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.registerNib(UINib(nibName: "MyFabuTableViewCell",bundle: nil), forCellReuseIdentifier: "MyFabuTableViewCell")
        self.view.addSubview(myTableView)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyFabuTableViewCell")as! MyFabuTableViewCell
        cell.setValueWithInfo(self.dataSource![indexPath.row])
        return cell
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
