//
//  TaskDetailViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/5.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let myTableView = UITableView()
    var taskInfo = TaskInfo()
    let mainHelper = MainHelper()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(taskInfo)
        myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        myTableView.backgroundColor = RGREY
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerNib(UINib(nibName: "TaskDetailTableViewCell1",bundle: nil), forCellReuseIdentifier: "cell1")
        myTableView.registerNib(UINib(nibName: "TaskDetailTableViewCell2",bundle: nil), forCellReuseIdentifier: "cell2")
        let btn = UIButton(frame: CGRectMake(15, myTableView.frame.size.height-118, WIDTH-30, 40))
        btn.layer.cornerRadius = 8
        btn.setTitle("立即抢单", forState: .Normal)
        btn.addTarget(self, action: #selector(self.qiangdan), forControlEvents: UIControlEvents.TouchUpInside)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = COLOR
//        btn.addTarget(self, action: #selector(self.nextToView), forControlEvent
        let view = UIView()
        myTableView.tableFooterView = view
        self.myTableView.addSubview(btn)
        self.view.addSubview(myTableView)
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        }else{
            return 50
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! TaskDetailTableViewCell1
            cell.call.addTarget(self, action: #selector(self.callPhone), forControlEvents: UIControlEvents.TouchUpInside)
            cell.selectionStyle = .None
            cell.icon.layer.cornerRadius = cell.icon.frame.size.height/2
            cell.icon.clipsToBounds = true
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! TaskDetailTableViewCell2
            cell.title.text = "任务号"
            cell.desc.text = self.taskInfo.order_num
            return cell
            
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! TaskDetailTableViewCell2
            cell.title.text = "任务"
            cell.desc.text = self.taskInfo.title
            return cell
            
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! TaskDetailTableViewCell2
            cell.title.text = "服务费"
            cell.desc.text = self.taskInfo.price
            return cell
            
        }else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! TaskDetailTableViewCell2
            cell.title.text = "上门地址"
            cell.desc.text = self.taskInfo.address
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! TaskDetailTableViewCell2
            cell.title.text = "有效期"
            let time = timeStampToString(self.taskInfo.time!)
            cell.desc.text = time
            tableView.separatorStyle = .None
            return cell
        }

    }
    
    func qiangdan(){
    
        print("抢单")
        let ud = NSUserDefaults.standardUserDefaults()
        let userid = ud.objectForKey("userid")as! String
        let longitude = ud.objectForKey("longitude")as! String
        let latitude = ud.objectForKey("latitude")as! String
        print(longitude)
        
        print(latitude)
        
        let str = String(longitude)
        let array:NSArray = str.componentsSeparatedByString("(")
        let str2 = array[1]as! String
        let array2 = str2.componentsSeparatedByString(")")
        let str3 = array2[0]
        print(str3)
        
        let str4 = String(latitude)
        let array3:NSArray = str4.componentsSeparatedByString("(")
        let str5 = array3[1]as! String
        let array4 = str5.componentsSeparatedByString(")")
        let str6 = array4[0]
        print(str6)
        
        
        mainHelper.qiangDan(userid, taskid: taskInfo.id!, longitude: str3, latitude: str6) { (success, response) in
            print(response)
            if !success {
                return
            }
            let vc = MyTaskViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
    
    }
    
    func callPhone(){
        
        print(self.taskInfo.phone!)
//        let phone = removeOptionWithString(self.taskInfo.phone!)
//        print(phone)
        UIApplication.sharedApplication().openURL(NSURL(string :"tel://"+"\(self.taskInfo.phone!)")!)
        
//        UIApplication.sharedApplication().openURL(NSURL(string :"tel://15974462468")!)
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
