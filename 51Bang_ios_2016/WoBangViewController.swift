//
//  WoBangViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/5.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class WoBangPageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var myTableView = UITableView()
    let mainHelper = MainHelper()
    let cityName = String()
    var longitude = String()
    var latitude = String()
    var dataSource : Array<TaskInfo>?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//        self.title = ""
//        self.navigationController!.title = "我帮"
        self.tabBarController?.tabBar.hidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        print(self.latitude)
        print(self.longitude)
        self.title = "我帮"
        self.createRightItemWithTitle("任务(0)")
//        self.createTableView()
        self.GetData()

//        self.view.backgroundColor = UIColor.redColor()
//        self.createLeftItemWithTitle("")
//        self.createRightItem()
        // Do any additional setup after loading the view.
    }
    
    func createRightItemWithTitle(title:String){
        let button = UIButton.init(type:.Custom)
        button.frame = CGRectMake(0, 0, 80, 40);
        button.setTitle(title, forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(self.myTask), forControlEvents: UIControlEvents.TouchUpInside)
        let item:UIBarButtonItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func myTask(){
        
        print(loginSign)
        if loginSign == 0 {
            
            self.tabBarController?.selectedIndex = 3
            
        }else{
            let vc = MyTaskViewController()
            vc.navigationController?.title = "我的任务"
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
    func GetData(){
    
//        shopHelper.getGoodsList({[unowned self] (success, response) in
//            dispatch_async(dispatch_get_main_queue(), {
//                if !success {
//                    return
//                }
//                print(response)
//                self.dataSource = response as? Array<GoodsInfo> ?? []
//                print(self.dataSource)
//                print(self.dataSource?.count)
//                self.createTableView()
//                //                self.ClistdataSource = response as? ClistList ?? []
//                self.myTableView.reloadData()
//                //self.configureUI()
//            })
//            })
        print(loginSign)
        if loginSign == 0 {
            
            self.tabBarController?.selectedIndex = 3
            
        }else{
            
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.animationType = .Zoom
            hud.labelText = "正在努力加载"
            let ud = NSUserDefaults.standardUserDefaults()
            let userid = ud.objectForKey("userid")as! String
            print(self.latitude)
            print(self.latitude)
            mainHelper.getTaskList (userid,cityName: self.cityName,longitude: self.longitude,latitude: self.latitude,handle: {[unowned self] (success, response) in
                dispatch_async(dispatch_get_main_queue(), {
                    if !success {
                        return
                    }
                    hud.hide(true)
                    print(response)
                    self.dataSource?.removeAll()
                    print(self.dataSource?.count)
                    self.dataSource = response as? Array<TaskInfo> ?? []
                    print(self.dataSource)
                    print(self.dataSource?.count)
                    self.createTableView()
                    //                self.ClistdataSource = response as? ClistList ?? []
                    self.myTableView.reloadData()
                    //self.configureUI()
                })
                
            })
        }
 
    }
    
    func createRightItem(){
        let mySwitch = UISwitch.init(frame: CGRectMake(0, 0, 40, 40))
        //        mySwitch.onImage = UIImage(named: "ic_xuanze")
        //        mySwitch.offImage = UIImage(named: "")
        let item:UIBarButtonItem = UIBarButtonItem.init(customView: mySwitch)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func createLeftItemWithTitle(title:String){
        let button = UIButton.init(type:.Custom)
        button.frame = CGRectMake(0, 0, 40, 40);
        let item:UIBarButtonItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = item
    }
    
    func createTableView(){
        myTableView.backgroundColor = RGREY
        self.myTableView = UITableView.init(frame: CGRectMake(0, -38, WIDTH, self.view.frame.size.height), style: .Grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .None
        myTableView.registerNib(UINib(nibName: "OrderTableViewCell",bundle: nil), forCellReuseIdentifier: "order")
//        let bottom = UIView(frame: CGRectMake(0, 0, WIDTH/2, 120))
        let btn = UIButton(frame: CGRectMake(0, HEIGHT-110, WIDTH/2,50))
        btn.alpha = 0.7
        btn.setTitle("我的任务", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = UIColor.grayColor()
        let label = UILabel()
        label.frame = CGRectMake(WIDTH/2, HEIGHT-109, 1, btn.frame.size.height-2)
        label.backgroundColor = UIColor.whiteColor()
        let btn2 = UIButton(frame: CGRectMake(WIDTH/2, HEIGHT-110, WIDTH/2,50))
        btn2.alpha = 0.7
        btn2.setTitle("刷新列表", forState: .Normal)
        btn2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn2.backgroundColor = UIColor.grayColor()
        btn.addTarget(self, action: #selector(self.nextToView), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(myTableView)
//        self.view.addSubview(btn)
//        self.view.addSubview(btn2)
//        self.view.addSubview(label)
       
    }
    
    func nextToView(){
        let vc = MyTaskViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSource?.count)!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("order") as! OrderTableViewCell
        cell.setValueWithInfo(self.dataSource![indexPath.row])
        
        cell.selectionStyle = .None
        cell.icon.layer.cornerRadius = cell.icon.frame.size.height/2
        cell.icon.clipsToBounds = true
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = TaskDetailViewController()
        let taskInfo = dataSource![indexPath.row]
        vc.taskInfo = taskInfo
        self.navigationController?.pushViewController(vc, animated: true)
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
