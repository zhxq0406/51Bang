//
//  AffirmOrderViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class AffirmOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let myTableView = UITableView()
    let textField = UITextField()
    let addButton = UIButton()
    let deleteButton = UIButton()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGREY
        self.navigationController?.title = "确认订单"
        self.createTableView()
        // Do any additional setup after loading the view.
    }

    func createTableView(){
    
        myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-50)
        myTableView.backgroundColor = RGREY
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.registerNib(UINib(nibName: "FabuTableViewCell3",bundle: nil), forCellReuseIdentifier: "peisong")
        myTableView.registerNib(UINib(nibName: "FabuTableViewCell1",bundle: nil), forCellReuseIdentifier: "address")
        myTableView.registerNib(UINib(nibName: "CNEETableViewCell",bundle: nil), forCellReuseIdentifier: "CNEE")
//        myTableView.registerNib(UINib(nibName: "FabuTableViewCell1",bundle: nil), forCellReuseIdentifier: "address")
        self.view.addSubview(myTableView)
    
        let view = UIView.init(frame: CGRectMake(0, 0, WIDTH, 50))
        view.backgroundColor = UIColor.whiteColor()
        let submit = UIButton.init(frame: CGRectMake(WIDTH-110, 0, 100, 50))
        submit.setTitle("提交订单", forState:UIControlState.Normal)
        submit.addTarget(self, action: #selector(self.goToBuy), forControlEvents: UIControlEvents.TouchUpInside)
        submit.backgroundColor = UIColor.orangeColor()
        view.addSubview(submit)
        myTableView.tableFooterView = view
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 2
        }else{
            return 3
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            return nil
        }else{
            let view = UIView.init(frame: CGRectMake(0, 0, WIDTH, 10))
            view.backgroundColor = RGREY
            return view
        }
        
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("CNEE")as! CNEETableViewCell
                cell.selectionStyle = .None
                return cell
            }else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCellWithIdentifier("CNEE")as! CNEETableViewCell
                cell.CNEE.text = "联系电话"
                cell.selectionStyle = .None
                cell.name.text = "1234567890"
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("address")as! FabuTableViewCell1
                cell.selectionStyle = .None
                cell.title.text = "收获地址"
                let textField = UITextField.init(frame: CGRectMake(80, cell.title.frame.origin.y, 200, cell.title.frame.size.height))
                textField.center = cell.title.center
                textField.placeholder = "请选择收获地址"
//                cell.addSubview(textField)
            
                return cell
            }
        }else if indexPath.section == 1{
        
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("CNEE")as! CNEETableViewCell
                cell.CNEE.text = "自助烤肉"
                cell.name.text = "103.3元"
                cell.selectionStyle = .None
                return cell
            }else if indexPath.row == 1{
            
                let cell = tableView.dequeueReusableCellWithIdentifier("CNEE")as! CNEETableViewCell
                cell.CNEE.text = "数量"
                cell.selectionStyle = .None
//                cell.name.text = "103.3元"
                textField.frame = CGRectMake(WIDTH-60, 10, 20, cell.CNEE.frame.size.height)
                textField.borderStyle = .Line
                
                textField.text = "0"
                addButton.frame = CGRectMake(textField.frame.origin.x+20, 10, 20, cell.CNEE.frame.size.height)
//                addButton.backgroundColor = UIColor.redColor()
                addButton.setTitle("加", forState: UIControlState.Normal)
                addButton.addTarget(self, action: #selector(self.add), forControlEvents: UIControlEvents.TouchUpInside)
                deleteButton.frame = CGRectMake(textField.frame.origin.x-20, 10, 20, cell.CNEE.frame.size.height)
                deleteButton.addTarget(self, action:#selector(self.deleteNum), forControlEvents: UIControlEvents.TouchUpInside)
//                deleteButton.backgroundColor = UIColor.redColor()
                deleteButton.setTitle("减", forState: UIControlState.Normal)
//                textField.leftView = deleteButton
//                textField.rightView = addButton
                cell.name.removeFromSuperview()
                cell.addSubview(textField)
                cell.addSubview(deleteButton)
                cell.addSubview(addButton)
                return cell
            
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("CNEE")as! CNEETableViewCell
                cell.CNEE.text = "小计"
                cell.selectionStyle = .None
                cell.name.text = "103.3元"
                return cell
            }

        }else{
        
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("peisong")as! FabuTableViewCell3
                cell.title.frame.origin.y = 20
                cell.mode.frame.origin.y = 20
                cell.selectionStyle = .None
                cell.bottomLabel.removeFromSuperview()
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("peisong")as! FabuTableViewCell3
                cell.title.text = "买家留言"
                cell.mode.removeFromSuperview()
                cell.title.frame.origin.y = 20
                cell.mode.frame.origin.y = 20
                cell.selectionStyle = .None
                cell.bottomLabel.removeFromSuperview()
                return cell
            }
  
        }
//        return nil
    }
    
    func add(){
    
        let num = Int(self.textField.text!)
        if num > 0 || num<100 {
            print(num)
            self.textField.text = String(num!+1)
            if num > 0 {
                self.addButton.enabled = true
            }
            if num == 100 {
                self.addButton.enabled = false
            }
           
        }
        
    }
    
    func deleteNum(){
    
        let num = Int(self.textField.text!)
        if num > 0 || num<100 {
            print(num)
            self.textField.text = String(num!-1)
            if num < 100 {
                self.deleteButton.enabled = true
            }
            if num == 0 {
                self.deleteButton.enabled = false
            }
           
        }
    }
    
    func goToBuy(){
    
    
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
