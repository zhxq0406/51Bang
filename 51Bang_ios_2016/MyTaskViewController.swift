//
//  MyTaskViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/5.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class MyTaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var myTableView = UITableView()
    var leftTableView = UITableView()
    var rightTableView = UITableView()
    let label = UILabel()
    let mainHelper = MainHelper()
    var dataSource : Array<TaskInfo>?
    var dataSource1 : Array<TaskInfo>?
    var dataSource2 : Array<TaskInfo>?
    var sign = Int()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sign = 1
        self.GetWKSData()
        self.title = "我的任务"
        self.view.backgroundColor = RGREY
        leftTableView.frame = CGRectMake(0,62, WIDTH, HEIGHT)
        leftTableView.tag = 0
//        leftTableView.hidden = true
        leftTableView.registerNib(UINib(nibName: "myOrderLocationTableViewCell",bundle: nil), forCellReuseIdentifier: "location")
        leftTableView.registerNib(UINib(nibName: "MyTaskTableViewCell1",bundle: nil), forCellReuseIdentifier: "cell1")
        leftTableView.registerNib(UINib(nibName: "MyTaskTableViewCell2",bundle: nil), forCellReuseIdentifier: "cell2")
        leftTableView.backgroundColor = UIColor.redColor()
        rightTableView.frame = CGRectMake(0, 62, WIDTH, HEIGHT)
        rightTableView.tag = 2
//        rightTableView.hidden = true
        rightTableView.backgroundColor = UIColor.blueColor()
        rightTableView.registerNib(UINib(nibName: "myOrderLocationTableViewCell",bundle: nil), forCellReuseIdentifier: "location")
        rightTableView.registerNib(UINib(nibName: "MyTaskTableViewCell1",bundle: nil), forCellReuseIdentifier: "cell1")
        rightTableView.registerNib(UINib(nibName: "MyTaskTableViewCell2",bundle: nil), forCellReuseIdentifier: "cell2")
        let view = UIView.init(frame: CGRectMake(0, 0, WIDTH, 52))
        view.backgroundColor = UIColor.whiteColor()
        let button1 = UIButton.init(frame: CGRectMake(0, 0, WIDTH/3, 50))
        button1.setTitle("未开始", forState: UIControlState.Normal)
        button1.addTarget(self, action: #selector(self.showLeft), forControlEvents: UIControlEvents.TouchUpInside)
        button1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        let button2 = UIButton.init(frame: CGRectMake(WIDTH/3, 0, WIDTH/3, 50))
        button2.setTitle("进行中", forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button2.addTarget(self, action: #selector(self.showMid), forControlEvents: UIControlEvents.TouchUpInside)
        let button3 = UIButton.init(frame: CGRectMake(WIDTH*2/3, 0, WIDTH/3, 50))
        button3.setTitle("已取消", forState: UIControlState.Normal)
        button3.addTarget(self, action: #selector(self.showRight), forControlEvents:  UIControlEvents.TouchUpInside)
        button3.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(label)
        self.view.addSubview(view)
       
        
//        self.view.addSubview(leftTableView)
//        self.view.addSubview(rightTableView)
        
       
        // Do any additional setup after loading the view.
    }
    
    func GetWKSData(){
    
        let ud = NSUserDefaults.standardUserDefaults()
        let userid = ud.objectForKey("userid")as! String
        mainHelper.GetTaskList (userid,state: "1",handle: {[unowned self] (success, response) in
            dispatch_async(dispatch_get_main_queue(), {
                if !success {
                    return
                }
                print(response)
                self.dataSource?.removeAll()
                print(self.dataSource?.count)
                self.dataSource = response as? Array<TaskInfo> ?? []
                self.dataSource1 = response as? Array<TaskInfo> ?? []
                self.dataSource2 = response as? Array<TaskInfo> ?? []
//                print(self.dataSource)
                print(self.dataSource?.count)
                print(self.dataSource1?.count)
                print(self.dataSource2?.count)
                self.createTableView()
                //                self.ClistdataSource = response as? ClistList ?? []
                self.myTableView.reloadData()
                //self.configureUI()
            })
            
            })
    }
    
    func createTableView(){
    
        
        myTableView.frame = CGRectMake(0, 62, WIDTH, HEIGHT)
        myTableView.tag = 1
        myTableView.backgroundColor = RGREY
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerNib(UINib(nibName: "MyOrderTableViewCell",bundle: nil), forCellReuseIdentifier: "MyOrderTableViewCell")
        myTableView.registerNib(UINib(nibName: "myOrderLocationTableViewCell",bundle: nil), forCellReuseIdentifier: "location")
        myTableView.registerNib(UINib(nibName: "MyTaskTableViewCell1",bundle: nil), forCellReuseIdentifier: "cell1")
        myTableView.registerNib(UINib(nibName: "MyTaskTableViewCell2",bundle: nil), forCellReuseIdentifier: "cell2")
        label.frame = CGRectMake(WIDTH/3, 50, WIDTH/3, 2)
        label.backgroundColor = COLOR
        
        let button4 = UIButton.init(frame: CGRectMake(10, HEIGHT-150, WIDTH/2-20, 50))
        button4.tag = 4
        button4.setTitle("联系对方", forState: UIControlState.Normal)
        button4.backgroundColor = UIColor.orangeColor()
        button4.layer.cornerRadius = 10
        let button5 = UIButton.init(frame: CGRectMake(WIDTH/2+10, HEIGHT-150, WIDTH/2-20, 50))
        button5.setTitle("完成服务", forState: UIControlState.Normal)
        button5.tag = 5
        button5.backgroundColor = COLOR
        button5.layer.cornerRadius = 10
        self.view.addSubview(myTableView)
//        self.view.addSubview(button4)
//        self.view.addSubview(button5)
    }
    
    func showLeft(){
        label.frame = CGRectMake(0, 50, WIDTH/3, 2)
        sign = 0
        self.myTableView.reloadData()
//        myTableView.hidden = true
//        leftTableView.hidden = false
//        rightTableView.hidden = true
//        leftTableView.reloadData()
        
        let button5 = self.view.viewWithTag(5)as! UIButton
        button5.setTitle("已上门", forState: UIControlState.Normal)
    }
    
    func showMid(){
    
        label.frame = CGRectMake(WIDTH/3, 50, WIDTH/3, 2)
        sign = 1
        self.myTableView.reloadData()
//        myTableView.hidden = false
//        leftTableView.hidden = true
//        rightTableView.hidden = true
//        myTableView.reloadData()
        let button5 = self.view.viewWithTag(5)as! UIButton
        button5.backgroundColor = COLOR
        button5.setTitle("完成服务", forState: UIControlState.Normal)
    }
    
    func showRight(){
        label.frame = CGRectMake(WIDTH*2/3, 50, WIDTH/3, 2)
        sign = 2
        self.myTableView.reloadData()
//        myTableView.hidden = true
//        leftTableView.hidden = true
//        rightTableView.hidden = false
//        rightTableView.reloadData()
        
        let button5 = self.view.viewWithTag(5)as! UIButton
        button5.backgroundColor = UIColor.grayColor()
    }
    
    func  numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if sign == 0 {
            print(self.dataSource?.count)
            return dataSource1!.count
        }else if sign == 1{
            
           return dataSource1!.count
            
        }else{
           return dataSource2!.count
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRectMake(0, 0, WIDTH, 10))
        view.backgroundColor = RGREY
        return view
    }
    
    
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return self.dataSource!.count
  
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
            return 200
    }
    
    
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            tableView.separatorStyle = .None
            var info = TaskInfo()
            if sign == 0 {
                info = self.dataSource![indexPath.section]
                print(info)
                
            }else if sign == 1{
            
                info = self.dataSource1![indexPath.row]
                print(info)
                
            }else{
                info = self.dataSource2![indexPath.row]
                print(info)
            }
        
            let cell = tableView.dequeueReusableCellWithIdentifier("MyOrderTableViewCell")as! MyOrderTableViewCell
            cell.selectionStyle = .None
            cell.setValueWithInfo(info)
            return cell
     }
    
    func dingwei(){
        
        let vc = LocationViewController()
        //        vc.longitude = Double(self.longitude)!
        //        vc.latitude = Double(self.latitude)!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = ConnectionViewController()
        vc.info = self.dataSource![indexPath.row]
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
