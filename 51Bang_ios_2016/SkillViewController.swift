//
//  SkillViewController.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
protocol myDelegate{
    //代理方法
    func createView()
}

class SkillViewController: UIViewController, cellDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate{
    
    
//    @IBOutlet weak var myTableView: UITableView!
    var myTableView = UITableView()
    let skillHelper = RushHelper()
    var dataSource : Array<SkillModel>?
    var ClistdataSource = ClistList()
    var array = NSMutableArray()
    var selectArr = NSMutableArray()
    var cellMarkArray:NSMutableArray?
    var cellMarkDic:NSMutableDictionary?
    var delegate:myDelegate?
//    NSMutableDictionary *cellMarkDic;
//    NSMutableArray *cellMarkArray;
    override func viewDidLoad() {
        super.viewDidLoad()
        cellMarkArray = NSMutableArray()
        self.GetData()
        
        let vc = RushViewController()
        self.delegate = vc
        
        // Do any additional setup after loading the view.
    }

  
    func GetData(){
        
        skillHelper.getSkillList({[unowned self] (success, response) in
            dispatch_async(dispatch_get_main_queue(), {
                if !success {
                    return
                }
                print(response)
                self.dataSource = response as? Array<SkillModel> ?? []
                print(self.dataSource)
                print(self.dataSource!.count)
                let num = self.dataSource!.count
                for i in 0..<num {
                    self.cellMarkDic = NSMutableDictionary()
                    self.cellMarkArray?.addObject(self.cellMarkDic!)
        //            cellMarkArray.addObject(cellMarkDic)
                    //            [cellMarkDic setObject:@"0" forKey:@"cellMark"];
                    //            [cellMarkArray addObject:cellMarkDic];
                }
                self.createTableView()
//                self.ClistdataSource = response as? ClistList ?? []
                self.myTableView.reloadData()
                //self.configureUI()
            })
        })

    }
    
    func createTableView(){
        myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, self.view.frame.size.height), style: .Grouped)
        myTableView.backgroundColor = RGREY
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .None
       
        myTableView.registerClass(SkillTableViewCell.self, forCellReuseIdentifier: "OneCell")
        
        myTableView.registerNib(UINib(nibName: "OneTableViewCell",bundle: nil), forCellReuseIdentifier: "One")
        myTableView.registerNib(UINib(nibName: "TwoTableViewCell",bundle: nil), forCellReuseIdentifier: "Two")
        myTableView.registerNib(UINib(nibName: "ThreeTableViewCell",bundle: nil), forCellReuseIdentifier: "Three")
        myTableView.registerNib(UINib(nibName: "HousekeepingTableViewCell",bundle: nil), forCellReuseIdentifier: "House")
        myTableView.registerNib(UINib(nibName: "FoveTableViewCell",bundle: nil), forCellReuseIdentifier: "Fove")
        myTableView.registerNib(UINib(nibName: "PetTableViewCell",bundle: nil), forCellReuseIdentifier: "Pet")
        myTableView.registerNib(UINib(nibName: "SevenTableViewCell",bundle: nil), forCellReuseIdentifier: "Seven")
        myTableView.registerNib(UINib(nibName: "MarriageTableViewCell",bundle: nil), forCellReuseIdentifier: "Marriage")
        
        let bottom = UIView(frame: CGRectMake(0, 0, WIDTH, 120))
        let btn = UIButton(frame: CGRectMake(15, 30, WIDTH-30, 50))
        btn.layer.cornerRadius = 8
        btn.setTitle("确认提交", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = COLOR
        btn.addTarget(self, action: #selector(self.nextToView), forControlEvents: .TouchUpInside)
        bottom.addSubview(btn)
        myTableView.tableFooterView = bottom
        self.view.addSubview(myTableView)
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.ClistdataSource.objectlist[section].name
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRectMake(0, 0, WIDTH, 40)
        view.backgroundColor = UIColor.whiteColor()
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, 5, 30, 20)
//        imageView.backgroundColor = UIColor.redColor()
        let titleLabel = UILabel()
        titleLabel.frame = CGRectMake(10, 5, 60, 20)
        let skillModel = self.dataSource![section]
        titleLabel.text = skillModel.name
//        view.addSubview(imageView)
        view.addSubview(titleLabel)
//        view.backgroundColor = UIColor.greenColor()
//        myTableView.tableHeaderView = view
        return view
        
    }
    

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.headerViewForSection(3)?.backgroundColor = UIColor.redColor()
        return 40
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource!.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let skillModel = self.dataSource![indexPath.section]
        let num = skillModel.clist.count
        if num==0 {
            return 0
        }else{
            return  CGFloat((num-1)/2+1) * WIDTH*60/375
        }

    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("OneCell")as? SkillTableViewCell
       
        if cell==nil {
            cell = SkillTableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: "OneCell")
        }
            cell!.delegate = self
            print(self.ClistdataSource.objectlist.count)
            let skillModel = self.dataSource![indexPath.section]
            
            let num = skillModel.clist.count
            print(skillModel.clist.count)
            cell!.setCellWithClistInfo(skillModel.clist,num: num)
            cell!.selectionStyle = .None
        for i in 0..<num {
            let button  = cell!.viewWithTag(i+10)as! UIButton
            print(selectArr)
            if selectArr.containsObject(button) {
                button.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)

            }
//            button.addTarget(self, action: #selector(click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
            return cell!

        
    }
    
    func addTager(btn:UIButton ){
        
        if selectArr.count == 0{
            btn.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
            selectArr.addObject(btn)
            //            self.payMode = cell.title.text!
            print(selectArr)
        }else{
            print(selectArr.count)
            if !selectArr.containsObject(btn){
                btn.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
                selectArr.addObject(btn)
                //                    self.payMode = cell.title.text!
                print(selectArr)
            }else{
                btn.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
                selectArr.removeObject(btn)
                print(selectArr)
            }
       }
    }
    
    func click(btn:UIButton){
//        let indexPath = NSIndexPath.init(forRow: 0 , inSection: 0)
//        let cell = self.myTableView.cellForRowAtIndexPath(indexPath)as! SkillTableViewCell
        if selectArr.count == 0{
            btn.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
            selectArr.addObject(btn)
//            self.payMode = cell.title.text!
            print(selectArr)
        }else{
            print(selectArr.count)
            if !selectArr.containsObject(btn){
                btn.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
                selectArr.addObject(btn)
                //                    self.payMode = cell.title.text!
                print(selectArr)
            }else{
                btn.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
                selectArr.removeObject(btn)
                print(selectArr)
            }
            
//            for btn1 in selectArr {
//                if btn1 as! NSObject == btn  {
//                    btn1.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
//                    selectArr.removeObject(btn1)
//                    print(selectArr)
////                    return
//                }else{
//                    
////                    for btn1 in selectArr {
////                        btn1.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
////                        selectArr.removeObject(btn1)
////                    }
//                    btn.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
//                    selectArr.addObject(btn)
////                    self.payMode = cell.title.text!
//                    print(selectArr)
////                    return
//                }
//            }
        }

        
        
    }
    func nextToView() {
        
        
        if loginSign == 0 {//未登陆
            
            self.tabBarController?.selectedIndex = 3
            
        }else{
            
            print("立即提交")
            let info = NSUserDefaults.standardUserDefaults()
            let array = info.objectForKey("infomation")as! NSArray
            print(array)
            print(array.count)
            
            self.createView()
            let ud = NSUserDefaults.standardUserDefaults()
            let userid = ud.objectForKey("userid")as! String
            //测试方便，以后打开
            if array.count<8 {
                let alert = UIAlertView.init(title: "温馨提示", message: "请完善信息", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }else{
                
                skillHelper.identityAffirm(userid, city: array[3] as! String, realname:array[4] as! String, idcard: array[5] as! String, contactperson: array[6] as! String, contactphone: array[7] as! String, positive_pic:array[0] as! String, opposite_pic:array[1] as! String, driver_pic: array[2] as! String) { (success, response) in
                    if success{
                        
                        print(response)
                        //let homepage = RushHomePageViewController()
                        //self.presentViewController(homepage, animated: true, completion: nil)
                        let ud = NSUserDefaults.standardUserDefaults()
                        ud.setObject("no", forKey: "ss")
                        ud.synchronize()
                        //self.navigationController?.pushViewController(homepage, animated: true)
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    }else{
                        let alert = UIAlertView.init(title: "温馨提示", message: "认证失败", delegate: self, cancelButtonTitle: "确定")
                        alert.show()
                    }
                }
                
            }

        }
        
    }
    
    func createView(){
    
       
        self.delegate?.createView()
    
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
