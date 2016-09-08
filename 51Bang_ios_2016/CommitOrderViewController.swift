//
//  CommitOrderViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/1.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class CommitOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    let formatter = NSDateFormatter()
    let mainHelper = MainHelper()
    let skillHelper = RushHelper()
    var dataSource = Array<SkillModel>()
    var cityName = String()
    var longitude:String = ""
    var latitude = String()
    var isShow = Bool()
    let coverView = UIView()
    let myTableView = UITableView()
    var pickerView:UIPickerView!
    var datePicker:UIDatePicker!
    let totalloc:Int = 4
    var taskTitle = String()
    var taskDescription = String()
    var salar = String()
    var time = String()
    let photoArray = NSMutableArray()
    var collectionV:UICollectionView?
    let photoNameArr = NSMutableArray()
    let array = ["跑腿","维修","家政","车辆","兼职","代办","宠物","丽人","婚恋","其他"]
    let array1 = ["按小时计费","按天计费","按月计费"]
    var address = String()
    let headerView = UIView()
    var shangMenLocation = String()
    var FuWuLocation = String()
    var phone = UITextField()
    var salary = UITextField()
    var shangmen = UITextField()
    var location = UITextField()
    var selectArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "帮我"
        self.view.backgroundColor = RGREY
        print(self.cityName)
        print(self.latitude)
        print(self.longitude)
        self.GetData()
        self.createTableView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
//        self.createTableViewHeaderView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func keyboardWillShow(note:NSNotification){
    
        let userInfo  = note.userInfo as! NSDictionary
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let deltaY = keyBoardBounds.size.height
        
        UIView.animateWithDuration(0.4, animations: {
            self.myTableView.frame.origin.y = -deltaY/2
        })

    }
    
    func keyboardWillHide(note:NSNotification){
    
        UIView.animateWithDuration(0.4, animations: {
            self.myTableView.frame.origin.y = 0
        })
    
    }
    
    
    func GetData(){
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.animationType = .Zoom
        hud.labelText = "正在努力加载"
        skillHelper.getSkillList({[unowned self] (success, response) in
            dispatch_async(dispatch_get_main_queue(), {
                if !success {
                    return
                }
                hud.hide(true)
                print(response)
                self.dataSource = response as? Array<SkillModel> ?? []
                print(self.dataSource)
                print(self.dataSource.count)
                self.createTableViewHeaderView()
//                self.createTableView()
                //                self.ClistdataSource = response as? ClistList ?? []
//                self.myTableView.reloadData()
                //self.configureUI()
            })
            })
    }
    
    func createTableView(){
        myTableView.frame = self.view.frame
        myTableView.backgroundColor = RGREY
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "textField")
        myTableView.registerNib(UINib(nibName: "IdentityTableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        myTableView.registerNib(UINib(nibName: "PhoneTableViewCell",bundle: nil), forCellReuseIdentifier: "phone")
        myTableView.registerNib(UINib(nibName: "LocationTableViewCell",bundle: nil), forCellReuseIdentifier: "location")
        myTableView.registerNib(UINib(nibName: "SalaryTableViewCell",bundle: nil), forCellReuseIdentifier: "salary")
        myTableView.registerNib(UINib(nibName: "DeadlineTableViewCell",bundle: nil), forCellReuseIdentifier: "data")
//        let view = UIView.init(frame: CGRectMake(0, 0, WIDTH, <#T##height: CGFloat##CGFloat#>))
        
        let bottom = UIView(frame: CGRectMake(0, 0, WIDTH, 150))
        let label = UILabel.init(frame: CGRectMake(0, 0,WIDTH, 50))
        label.text = "服务费****"
        label.textAlignment = .Center
//        bottom.backgroundColor = UIColor.redColor()
        let btn = UIButton(frame: CGRectMake(15, 50, WIDTH-30, 50))
        btn.layer.cornerRadius = 8
        btn.setTitle("提交订单", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = COLOR
        btn.addTarget(self, action: #selector(self.nextToView), forControlEvents: .TouchUpInside)
        bottom.addSubview(label)
        bottom.addSubview(btn)
        myTableView.tableFooterView = bottom
        
        self.view.addSubview(myTableView)
        
        self.view.addSubview(myTableView)
    }

    func nextToView(){
    
        //上传订单  http://bang.xiaocool.net/index.php?g=apps&m=index&a=publishTask&userid=1&title=找人帮我送快递&description=我有一个非常重要的凯蒂,需要帮我送人&address=北京市朝阳区&longitude=121.39138199999999&latitude=12.888&expirydate=219312&price=100&type=2
        print(self.cityName)
        print(self.taskTitle)
        print(self.taskDescription)
        print(self.time)
        print(self.salar)
//        print(self.longitude as! String)
        print(self.longitude)
        print(String(self.longitude))
//        let str = String(self.longitude)
//        let array:NSArray = str.componentsSeparatedByString("(")
//        let str2 = array[1]as! String
//        let array2 = str2.componentsSeparatedByString(")")
//        let str3 = array2[0]
//        print(str3)
        
        
        //经纬度需要查看
        print(loginSign)
        //需要登录
        if loginSign == 0 {
            
            self.tabBarController?.selectedIndex = 3
            
        }else{
            //        http://bang.xiaocool.net/index.php?g=apps&m=index&a=getTaskListByCity&userid=1&city=烟台&longitude=121.39138199999999&latitude=37.539296999999998
            let ud = NSUserDefaults.standardUserDefaults()
            let userid = ud.objectForKey("userid") as! String
//            if self.time == "请选择有效时间"||self.taskTitle == ""||self.taskDescription == ""||self.cityName==""||self.salar=="" {
//                alert("请完善信息", delegate: self)
//                return
//            }
//            
            print(self.time)
//            let time = stringToTimeStamp(self.time)
//            print(time)
            
            
            
            mainHelper.upLoadOrder(userid, title: self.taskTitle, description: self.taskDescription, address: self.cityName, longitude: String(self.longitude), latitude: String(self.latitude),expirydate:time,price:self.salar) { (success, response) in
                if !success{
                    return
                }
                print(response!)
                let userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject(response!, forKey: "ordernumber")
                print("上传合同")
                let vc = UploadContractViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
   
    }
    
    
    
    
    func createTableViewHeaderView(){
        print(self.dataSource.count)
         headerView.frame = CGRectMake(0, 0, WIDTH, 250)
//        view.backgroundColor = UIColor.grayColor()
        let myTableViwWidth = self.myTableView.frame.size.width
        let margin:CGFloat = (myTableViwWidth-CGFloat(self.totalloc) * WIDTH*95/375)/(CGFloat(self.totalloc)+1);
        print(margin)
        for i in 0..<self.dataSource.count{
            let row:Int = i / totalloc;//行号
            //1/3=0,2/3=0,3/3=1;
            let loc:Int = i % totalloc;//列号
            let appviewx:CGFloat = margin+(margin+myTableViwWidth/CGFloat(self.totalloc))*CGFloat(loc)
            let appviewy:CGFloat = margin+(margin+WIDTH*40/375) * CGFloat(row)
            let btn = UIButton()
       
            btn.addTarget(self, action: #selector(self.onCLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//            btn.backgroundColor = UIColor.redColor()
            btn.frame = CGRectMake(appviewx+3, appviewy+3, WIDTH*80/375, WIDTH*30/375)
            btn.layer.cornerRadius = WIDTH*10/375
            btn.layer.borderWidth = 1
            btn.layer.borderColor = COLOR.CGColor
            btn.setTitleColor(COLOR, forState: UIControlState.Normal)
            let label = UILabel.init(frame: CGRectMake(0, 0, btn.frame.width, btn.frame.height))
            let model = self.dataSource[i]
            label.text = model.name
//            label.text = array[i]
            label.textColor = COLOR
            label.textAlignment = .Center
            btn.addSubview(label)
            headerView.addSubview(btn)
            
        }
        let textView = PlaceholderTextView.init(frame: CGRectMake(0, WIDTH*165/375, WIDTH, 180))
        textView.tag = 1
        textView.backgroundColor = UIColor.whiteColor()
        textView.delegate = self
        textView.textAlignment = .Left
        textView.editable = true
        textView.layer.cornerRadius = 4.0
        //        textView.layer.borderColor = kTextBorderColor.CGColor
        textView.layer.borderWidth = 0.5
        textView.placeholder = "请输入您要发布的信息内容"
        let button = UIButton.init(frame: CGRectMake(20, textView.frame.size.height-30, 30, 30))
        button.setImage(UIImage(named: "ic_tupian"), forState: UIControlState.Normal)
        let yinPin = UIButton.init(frame: CGRectMake(80, textView.frame.size.height-30, 30, 30))
        yinPin.setImage(UIImage(named: "ic_yinpin"), forState: UIControlState.Normal)
        
        let shiPin = UIButton.init(frame: CGRectMake(140, textView.frame.size.height-30, 30, 30))
        shiPin.setImage(UIImage(named: "ic_shipin"), forState: UIControlState.Normal)
        //        let gesture = UITapGestureRecognizer(target: self, action: "viewTap:")
        //附加识别器到视图
        //        button.addGestureRecognizer(gesture)
        button.addTarget(self, action: #selector(self.goToCamera1(_:)), forControlEvents: .TouchUpInside)
        textView.addSubview(button)
        textView.addSubview(yinPin)
//        textView.addSubview(shiPin)
        headerView.addSubview(textView)
        headerView.frame.size.height = WIDTH*180/375+WIDTH*180/375
        
//        view.backgroundColor = UIColor.redColor()
        self.myTableView.tableHeaderView = headerView
       
    }
    
    func onCLick(btn:UIButton){
        
        if selectArr.count == 0{
//            btn.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
            btn.backgroundColor = COLOR
//            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            let label =  btn.subviews[0]as! UILabel
            label.textColor = UIColor.whiteColor()
            selectArr.addObject(btn)
            //            self.payMode = cell.title.text!
            print(selectArr)
        }else{
            print(selectArr.count)
            if !selectArr.containsObject(btn){
                btn.backgroundColor = COLOR
//                btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                let label =  btn.subviews[0]as! UILabel
                label.textColor = UIColor.whiteColor()
//                btn.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
                selectArr.addObject(btn)
                //                    self.payMode = cell.title.text!
                print(selectArr)
            }else{
//                btn.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
                btn.backgroundColor = RGREY
//                btn.setTitleColor(COLOR, forState: UIControlState.Normal)
                let label =  btn.subviews[0]as! UILabel
                label.textColor = COLOR
                selectArr.removeObject(btn)
                print(selectArr)
            }
        }

    
    }
    
    
    func goToCamera1(btn:UIButton){
        
        print("上传图片")
        print(btn.tag)
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    //上传图片的协议与代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage]as! UIImage
        self.photoArray.addObject(image)
        print(self.photoArray)
        self.addCollectionViewPicture()
        let data = UIImageJPEGRepresentation((info[UIImagePickerControllerEditedImage] as? UIImage)!, 0.1)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr = dateFormatter.stringFromDate(NSDate())
        let imageName = "avatar" + dateStr
        
        //上传图片
        ConnectModel.uploadWithImageName(imageName, imageData: data, URL: "http://bang.xiaocool.net/index.php?g=apps&m=index&a=uploadimg") { [unowned self] (data) in
            dispatch_async(dispatch_get_main_queue(), {
                
                let result = Http(JSONDecoder(data))
                if result.status != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        if result.status! == "success"{
                            self.photoNameArr.addObject(result.data!)
                            
                        }else{
                            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                            hud.mode = MBProgressHUDMode.Text;
                            hud.labelText = "图片上传失败"
                            hud.margin = 10.0
                            hud.removeFromSuperViewOnHide = true
                            hud.hide(true, afterDelay: 1)
                        }
                    })
                }
            })
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addCollectionViewPicture(){
        
        let flowl = UICollectionViewFlowLayout.init()
        //设置每一个item大小
        flowl.itemSize = CGSizeMake((WIDTH-60)/3, (WIDTH-60)/3)
        flowl.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
        flowl.minimumInteritemSpacing = 10
        flowl.minimumLineSpacing = 10
        print(self.photoArray.count)
        var height =  CGFloat(((self.photoArray.count-1)/3))*((WIDTH-60)/3+10)+((WIDTH-60)/3+10)
        if self.photoArray.count == 0 {
            height = 0
        }
                //创建集合视图
        self.collectionV = UICollectionView.init(frame: CGRectMake(0, WIDTH*180/375+WIDTH*200/375, WIDTH, height), collectionViewLayout: flowl)
        collectionV!.backgroundColor = UIColor.whiteColor()
        collectionV!.delegate = self
        collectionV!.dataSource = self
        //        collectionV?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "photo")
        collectionV!.registerNib(UINib(nibName: "PhotoCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "photo")
        self.headerView.addSubview(collectionV!)
        self.headerView.frame.size.height = WIDTH*200/375+WIDTH*180/375+(collectionV?.frame.size.height)!
        self.myTableView.tableHeaderView = self.headerView
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.photoArray.count)
        if self.photoArray.count == 0 {
            return 0
        }else{
            
            return photoArray.count
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photo", forIndexPath: indexPath)as! PhotoCollectionViewCell
        print(self.photoArray[indexPath.item] as? UIImage)
        cell.button.setBackgroundImage(self.photoArray[indexPath.item] as? UIImage, forState: UIControlState.Normal)
        
        let button = UIButton.init(frame: CGRectMake(cell.frame.size.width-18, 0, 20, 20))
        button.setImage(UIImage(named: "ic_shanchu-cha"), forState: UIControlState.Normal)
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(self.deleteImage(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSubview(button)
        return cell
    }
    
    //删除照片
    func deleteImage(btn:UIButton){
        print(btn.tag)
        self.photoArray.removeObjectAtIndex(btn.tag)
//        self.collectionV?.deleteItemsAtIndexPaths([NSIndexPath.init(index: btn.tag)])
        self.collectionV?.reloadData()
        if self.photoArray.count == 0 {
            self.collectionV?.frame.size.height = 0
            self.collectionV?.removeFromSuperview()
            self.addCollectionViewPicture()


//            self.headerView.frame.size.height = WIDTH*200/375+WIDTH*200/375
//            self.myTableView.reloadData()
        }
        
    }
    

//    
//    func createTextView(){
////        headerView.frame = CGRectMake(0, 0, WIDTH, 250)
////        //                headerView.backgroundColor = UIColor.greenColor()
////        
////        mytextView.frame = CGRectMake(10, 0, WIDTH, 60)
////        mytextView.placeholder = "特卖商品名称"
//        
//        let textView = PlaceholderTextView.init(frame: CGRectMake(0, 60, WIDTH, 180))
//        textView.tag = 1
//        textView.backgroundColor = UIColor.whiteColor()
//        textView.delegate = self
//        textView.textAlignment = .Left
//        textView.editable = true
//        textView.layer.cornerRadius = 4.0
//        //        textView.layer.borderColor = kTextBorderColor.CGColor
//        textView.layer.borderWidth = 0.5
//        textView.placeholder = "请输入您要发布的信息内容"
//        let button = UIButton.init(frame: CGRectMake(20, textView.frame.size.height-30, 30, 30))
//        button.setImage(UIImage(named: "ic_tupian"), forState: UIControlState.Normal)
//        let yinPin = UIButton.init(frame: CGRectMake(80, textView.frame.size.height-30, 30, 30))
//        yinPin.setImage(UIImage(named: "ic_yinpin"), forState: UIControlState.Normal)
//        
//        let shiPin = UIButton.init(frame: CGRectMake(140, textView.frame.size.height-30, 30, 30))
//        shiPin.setImage(UIImage(named: "ic_shipin"), forState: UIControlState.Normal)
//        //        let gesture = UITapGestureRecognizer(target: self, action: "viewTap:")
//        //附加识别器到视图
//        //        button.addGestureRecognizer(gesture)
//        button.addTarget(self, action: #selector(self.goToCamera1(_:)), forControlEvents: .TouchUpInside)
//        textView.addSubview(button)
//        textView.addSubview(yinPin)
//        textView.addSubview(shiPin)
//        let line = UILabel.init(frame: CGRectMake(0, button.frame.size.height+button.frame.origin.y+10, WIDTH, 1))
//        line.backgroundColor = RGREY
//        headerView.addSubview(mytextView)
//        headerView.addSubview(textView)
//        //        headerView.addSubview(line)
//        self.mytableView.tableHeaderView = headerView
//        //        myTableViw.tableHeaderView = textView
//        //        self.view.addSubview(textView)
//    }
//
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let view = UIView.init(frame: CGRectMake(0, 0, self.myTableView.frame.size.width,WIDTH*50/375))
//        view.backgroundColor = UIColor.redColor()
//        self.myTableView.tableHeaderView = view
//        return view
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.separatorStyle = .None
        let ud = NSUserDefaults.standardUserDefaults()
        let phone = ud.objectForKey("phone")as!String
        print(phone)
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("phone", forIndexPath: indexPath)as! PhoneTableViewCell
            cell.selectionStyle = .None
//            cell.phone.borderStyle = .None
            cell.phone.tag = 100
//            cell.phone.delegate = self
            cell.phone.text = phone
//            self.phone = phone
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("location",forIndexPath: indexPath)as! LocationTableViewCell
            cell.textField.text = self.address
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(self.address, forKey: "shangMenLocation")
            self.shangMenLocation = self.address
            cell.textField.borderStyle = .None
            cell.textField.tag = 200
            self.shangmen = cell.textField
            cell.textField.delegate = self
            cell.locationButton.tag = 0
//            cell.desc.text = self.address
            cell.locationButton.addTarget(self, action: #selector(self.dingwei(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            cell.selectionStyle = .None 
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCellWithIdentifier("location",forIndexPath: indexPath)as! LocationTableViewCell
            cell.title.text = "服务地点"
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(self.address, forKey: "FuWuLocation")
            cell.textField.text = self.address
            self.location = cell.textField
            self.FuWuLocation = self.address
            cell.textField.delegate = self
            cell.textField.borderStyle = .None
            cell.textField.tag = 11
//            cell.desc.text = self.address
            cell.locationButton.tag = 1
            cell.locationButton.addTarget(self, action: #selector(self.dingwei(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            cell.icon.image = UIImage(named: "ic_fuwudidian")
            cell.selectionStyle = .None
            return cell
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCellWithIdentifier("salary",forIndexPath: indexPath)as! SalaryTableViewCell
            
            cell.button.addTarget(self, action: #selector(self.chooseMothed), forControlEvents: UIControlEvents.TouchUpInside)
            //建立手势识别器
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.myTap(_:)))
            //附加识别器到视图
            cell.mothed.addGestureRecognizer(gesture)
            self.salary = cell.salary
            cell.mothed.userInteractionEnabled = true
            cell.mothed.tag = 10
            cell.salary.tag = 99
            self.salar = cell.salary.text!
            cell.selectionStyle = .None
//            cell.accessoryType = .DisclosureIndicator
            return cell
        }else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCellWithIdentifier("data",forIndexPath: indexPath)as! DeadlineTableViewCell
            cell.selectionStyle = .None
           
            cell.timeButton.addTarget(self, action: #selector(self.chooseDate), forControlEvents: UIControlEvents.TouchUpInside)
           
            cell.button.addTarget(self, action: #selector(self.chooseDate), forControlEvents: UIControlEvents.TouchUpInside)
            cell.timeButton.tag = 12
//            cell.time.borderStyle = .None
            self.time = cell.timeButton.currentTitle!
//            cell.accessoryType = .DisclosureIndicator
            return cell
        }else{
           let cell = tableView.dequeueReusableCellWithIdentifier("data",forIndexPath: indexPath)as! DeadlineTableViewCell
            cell.selectionStyle = .None
            return cell
        }
    }
    
    func viewTap(sender: UITapGestureRecognizer) {
        self.chooseDate()
    }
    func myTap(sender: UITapGestureRecognizer) {
        self.chooseMothed()
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        if textField.tag == 11 {//服务地点
//            //            textField.becomeFirstResponder()
//            //            let phone = self.view.viewWithTag(100)
//            //            let salary = self.view.viewWithTag(99)
//            //            let shangmen = self.view.viewWithTag(10)
//            //            shangmen?.resignFirstResponder()
//            //            phone?.resignFirstResponder()
//            //            salary?.resignFirstResponder()
////            let location = self.view.viewWithTag(11)as!UITextField
////            textField.becomeFirstResponder()
//            self.location.becomeFirstResponder()
//            return true
//        }else if textField.tag == 99{//工资
//            //            let location = self.view.viewWithTag(11)
//            //            let phone = self.view.viewWithTag(100)
//            //            let shangmen = self.view.viewWithTag(10)
//            //            shangmen?.resignFirstResponder()
//            //            location?.resignFirstResponder()
//            //            phone?.resignFirstResponder()
////            let salary = self.view.viewWithTag(99)as! UITextField
//            self.salary.becomeFirstResponder()
////            textField.becomeFirstResponder()
//            //            textField.becomeFirstResponder()
//            return true
//        }else if textField.tag == 10{//上门地点
//            //            textField.becomeFirstResponder()
//            //            let phone = self.view.viewWithTag(100)
//            //            let location = self.view.viewWithTag(11)
//            //            let salary = self.view.viewWithTag(99)
//            //            salary?.resignFirstResponder()
//            //            phone?.resignFirstResponder()
//            //            location?.resignFirstResponder()
////            let shangmen = self.view.viewWithTag(10)as! UITextField
////            textField.becomeFirstResponder()
//            self.location.becomeFirstResponder()
//            return true
//        }else{//电话
//            //            let location = self.view.viewWithTag(11)
//            //            let salary = self.view.viewWithTag(99)
//            //            let shangmen = self.view.viewWithTag(10)
//            //            shangmen?.resignFirstResponder()
//            //            location?.resignFirstResponder()
//            //            salary?.resignFirstResponder()
////            let phone = self.view.viewWithTag(100)as! UITextField
////            textField.becomeFirstResponder()
//            self.phone.becomeFirstResponder()
//            return true
//        }
//
//    }
//    
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        //电话 100  工资99    服务地点11  上门地点10
//        if textField.tag == 11 {//服务地点
////            textField.becomeFirstResponder()
////            let phone = self.view.viewWithTag(100)
////            let salary = self.view.viewWithTag(99)
////            let shangmen = self.view.viewWithTag(10)
////            shangmen?.resignFirstResponder()
////            phone?.resignFirstResponder()
////            salary?.resignFirstResponder()
////            let location = self.view.viewWithTag(11)as!UITextField
////            textField.becomeFirstResponder()
//            self.location.becomeFirstResponder()
//            return true
//        }else if textField.tag == 99{//工资
////            let location = self.view.viewWithTag(11)
////            let phone = self.view.viewWithTag(100)
////            let shangmen = self.view.viewWithTag(10)
////            shangmen?.resignFirstResponder()
////            location?.resignFirstResponder()
////            phone?.resignFirstResponder()
////            let salary = self.view.viewWithTag(99)as! UITextField
////            textField.becomeFirstResponder()
////            textField.becomeFirstResponder()
//            self.salary.becomeFirstResponder()
//            return true
//        }else if textField.tag == 10{//上门地点
////            textField.becomeFirstResponder()
////            let phone = self.view.viewWithTag(100)
////            let location = self.view.viewWithTag(11)
////            let salary = self.view.viewWithTag(99)
////            salary?.resignFirstResponder()
////            phone?.resignFirstResponder()
////            location?.resignFirstResponder()
////            let shangmen = self.view.viewWithTag(10)as! UITextField
////            textField.becomeFirstResponder()
//            self.shangmen.becomeFirstResponder()
//            return true
//        }else{//电话
////            let location = self.view.viewWithTag(11)
////            let salary = self.view.viewWithTag(99)
////            let shangmen = self.view.viewWithTag(10)
////            shangmen?.resignFirstResponder()
////            location?.resignFirstResponder()
////            salary?.resignFirstResponder()
////            let phone = self.view.viewWithTag(100)as! UITextField
////            textField.becomeFirstResponder()
//            self.phone.becomeFirstResponder()
//            return true
//        }
//    }
    
    func textFieldEditChanged(textField:UITextField)
    
    {
        self.taskTitle = textField.text!
        self.taskDescription = textField.text!
        print("textfield text %@",textField.text);
    
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.taskTitle = textField.text!
        self.taskDescription = textField.text!
        print(textField.text);
        
        if textField.tag == 10 {
            self.shangMenLocation = textField.text!
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(self.shangMenLocation, forKey: "shangMenLocation")
            ud.synchronize()
            print(self.shangMenLocation)
            
        }else if textField.tag == 11{
        
            self.FuWuLocation = textField.text!
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(self.FuWuLocation, forKey: "FuWuLocation")
            ud.synchronize()
            print(self.FuWuLocation)
        }
        
    }
    func chooseDate(){
    
        let phone = self.view.viewWithTag(100)
        let textField = self.view.viewWithTag(99)
        let location = self.view.viewWithTag(11)
        let shangmen = self.view.viewWithTag(200)
        textField?.resignFirstResponder()
        location?.resignFirstResponder()
        phone?.resignFirstResponder()
        shangmen?.resignFirstResponder()
        
        if isShow == false {
            coverView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-48)
            coverView.backgroundColor = UIColor.grayColor()
            coverView.alpha = 0.8
//            let view = UIView()
            let view2 = UIView()
            view2.tag = 51
            view2.frame = CGRectMake(0, HEIGHT-400, WIDTH, 350)
            view2.backgroundColor = UIColor.whiteColor()
            let label = UILabel.init(frame: CGRectMake(0, 0, WIDTH, 30))
            label.text = "选择服务时间"
            label.textAlignment = .Center
//            pickerView=UIDatePicker()
            datePicker = UIDatePicker()
            datePicker.tag = 101
            datePicker.frame = CGRectMake(0, 30, WIDTH, 180)
//            datePicker.backgroundColor = UIColor.redColor()
            datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
            //注意：action里面的方法名后面需要加个冒号“：”
            datePicker.addTarget(self, action: #selector(self.dateChanged(_:)),
                                 forControlEvents: UIControlEvents.ValueChanged)
            
            let button1 = UIButton.init(frame: CGRectMake(0, datePicker.frame.size.height+datePicker.frame.origin.y, WIDTH/2, 50))
            let button2 = UIButton.init(frame: CGRectMake(WIDTH/2, datePicker.frame.size.height+datePicker.frame.origin.y, WIDTH/2, 50))
            button1.setTitle("取消", forState: UIControlState.Normal)
//            button1.backgroundColor = UIColor.greenColor()
            button1.tintColor = UIColor.blackColor()
            button1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button1.tag = 201
            button1.addTarget(self, action: #selector(self.click1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button2.setTitle("确定", forState: UIControlState.Normal)
//            button2.backgroundColor = UIColor.greenColor()
            button2.tintColor = UIColor.blackColor()
            button2.addTarget(self, action: #selector(self.click1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button2.tag = 202
            view2.addSubview(label)
            view2.addSubview(datePicker)
            view2.addSubview(button1)
            view2.addSubview(button2)
//            coverView.addSubview(view)
            
            self.view.addSubview(coverView)
            self.view.addSubview(view2)
            isShow = true
        }else{
            coverView.removeFromSuperview()
            let view = self.view.viewWithTag(51)
            view!.removeFromSuperview()
            //            coverView.frame = CGRectMake(0, 0, 0, 0)
            isShow = false
        }

    
    }
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
//        let formatter = NSDateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print(formatter.stringFromDate(datePicker.date))
    }
    
    func chooseMothed(){
        
        let phone = self.view.viewWithTag(100)
        let textField = self.view.viewWithTag(99)
        let location = self.view.viewWithTag(11)
        let shangmen = self.view.viewWithTag(200)
        shangmen?.resignFirstResponder()
        textField?.resignFirstResponder()
        location?.resignFirstResponder()
        phone?.resignFirstResponder()
        
        if isShow == false {
            coverView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-48)
            coverView.backgroundColor = UIColor.grayColor()
            coverView.alpha = 0.8
            let view1 = UIView()
            view1.tag = 50
            view1.frame = CGRectMake(0, HEIGHT-400, WIDTH, 350)
            view1.backgroundColor = UIColor.whiteColor()
            let label = UILabel.init(frame: CGRectMake(0, 0, WIDTH, 30))
            label.text = "选择计费方式"
            label.textAlignment = .Center
            let line = UILabel.init(frame: CGRectMake(0, 30, WIDTH, 1))
            line.backgroundColor = UIColor.blueColor()
            pickerView=UIPickerView()
            pickerView.tag = 100
            pickerView.frame = CGRectMake(50, 30, 200, 200)
//            pickerView.backgroundColor = UIColor.redColor()
            //将dataSource设置成自己
            pickerView.dataSource=self
            //将delegate设置成自己
            pickerView.delegate=self
            let button1 = UIButton.init(frame: CGRectMake(0, pickerView.frame.size.height+pickerView.frame.origin.y, WIDTH/2, 50))
            let button2 = UIButton.init(frame: CGRectMake(WIDTH/2, pickerView.frame.size.height+pickerView.frame.origin.y, WIDTH/2, 50))
            button1.setTitle("取消", forState: UIControlState.Normal)
            button1.tag = 1
            button1.addTarget(self, action: #selector(self.click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button1.titleLabel?.textColor = UIColor.blackColor()
            button2.setTitle("确定", forState: UIControlState.Normal)
//            button2.titleLabel?.textColor = UIColor.blackColor()
            button1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button2.addTarget(self, action: #selector(self.click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button2.tag = 2
            let line1 = UILabel.init(frame: CGRectMake(0, button1.frame.origin.y, WIDTH, 1))
            line1.backgroundColor = UIColor.blueColor()
            
            view1.addSubview(label)
            view1.addSubview(line)
            view1.addSubview(pickerView)
            view1.addSubview(button1)
            view1.addSubview(button2)
            view1.addSubview(line1)
            self.view.addSubview(coverView)
            self.view.addSubview(view1)
            isShow = true
        }else{
            coverView.removeFromSuperview()
            let view = self.view.viewWithTag(50)
            view!.removeFromSuperview()
            //            coverView.frame = CGRectMake(0, 0, 0, 0)
            isShow = false
        }
    
    }
    
    func click(btn:UIButton){
        
        if btn.tag == 1 {
            print("取消")
            
//            pickerView.removeFromSuperview()
            coverView.removeFromSuperview()
            let view = self.view.viewWithTag(50)
            view!.removeFromSuperview()
            isShow = false
        }else{
            coverView.removeFromSuperview()
            let view = self.view.viewWithTag(50)
            view!.removeFromSuperview()
            isShow = false
            let label = self.view.viewWithTag(10)as! UILabel
            let index = pickerView.selectedRowInComponent(0)
            label.text = array1[index]
        }
        
    }
    //时间
    func click1(btn:UIButton){
        
        
        if btn.tag == 201{
            print("取消")
            
            //            pickerView.removeFromSuperview()
            coverView.removeFromSuperview()
            let view = self.view.viewWithTag(51)
            view!.removeFromSuperview()
            isShow = false
        }else if btn.tag == 202{
            let datestr = formatter.stringFromDate(datePicker.date)
            self.time = datestr
            let button = self.view.viewWithTag(12)as! UIButton
            button.setTitle(datestr, forState: UIControlState.Normal)
            //            textField.text = datestr
            print("---")
            print(datestr)
            print("---")
            //            datePicker.removeFromSuperview()
            coverView.removeFromSuperview()
            let view = self.view.viewWithTag(51)
            view!.removeFromSuperview()
            isShow = false
            //            let label = self.view.viewWithTag(10)as! UILabel
            //            let index = pickerView.selectedRowInComponent(0)
            //            label.text = array1[index]
        }
        
        
    
        
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
            if pickerView.tag == 100 {
                 return array1[row]
            }else{
            
                return nil
            }
           
    }
    
    //设置列宽
    func pickerView(pickerView: UIPickerView,widthForComponent component: Int) -> CGFloat{
//        if(0 == component){
//            //第一列变宽
//            return 100
//        }else{
//            //第二、三列变窄
            return 200
//        }
    }
    
    //设置行高
    func pickerView(pickerView: UIPickerView,rowHeightForComponent component: Int) -> CGFloat{
        return 50
    }
    
    //设置选择框的列数为1列,继承于UIPickerViewDataSource协议
    func numberOfComponentsInPickerView( pickerView: UIPickerView) -> Int{
        if pickerView.tag == 100 {
            return 1
        }else{
            return 3
        }
        
    }
    //设置选择框的行数为3行，继承于UIPickerViewDataSource协议
    func pickerView(pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        return 3
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        print(component)
        print(row)
        
        
    }
    
    func dingwei(btn:UIButton){
    
        let vc = LocationViewController()
        if btn.tag == 0 {
            vc.address = self.shangMenLocation
        }else if btn.tag == 1{
        
            vc.address = self.FuWuLocation
        }
//        vc.longitude = Double(self.longitude)!
//        vc.latitude = Double(self.latitude)!
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
//    
//    func textFieldDidBeginEditing(textField: UITextField) {
//
//        UIView.animateWithDuration(0.4, animations: {
//            self.myTableView.frame.origin.y = -100
//        })
//    }
//    
//    func tapBackground(){
//        let tap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(CommitOrderViewController.tapOnce))
//        tap.numberOfTouchesRequired=1
//        self.myTableView.addGestureRecognizer(tap)
//    }
//    func tapOnce(){
//        
//        UIView.animateWithDuration(0.4, animations: {
//            self.myTableView.frame.origin.y = 0
//        })
//        let textField = self.view.viewWithTag(100)as! UITextField
//        textField.resignFirstResponder()
//        
//    }
    
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
