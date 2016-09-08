//
//  ConnectionViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/21.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class ConnectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var info = TaskInfo()
    let myTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        myTableView.backgroundColor = RGREY
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.registerNib(UINib(nibName: "MyOrderTableViewCell",bundle: nil), forCellReuseIdentifier: "MyOrderTableViewCell")
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
        self.view.addSubview(button4)
        self.view.addSubview(button5)
        // Do any additional setup after loading the view.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 200
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print(self.info)
        tableView.separatorStyle = .None
        let cell = tableView.dequeueReusableCellWithIdentifier("MyOrderTableViewCell")as! MyOrderTableViewCell
        cell.selectionStyle = .None
        cell.setValueWithInfo(info)
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
