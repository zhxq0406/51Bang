//
//  CertificationViewController.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import AssetsLibrary
import MBProgressHUD

class CertificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var array = NSMutableArray()
    var cellIndexpath = Int()
    var imagenameArray = NSMutableArray()
    override func viewWillAppear(animated: Bool) {
        myTableView.reloadData()
        self.tabBarController?.tabBar.hidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.backgroundColor = RGREY
        
        myTableView.backgroundColor = RGREY
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerNib(UINib(nibName: "IdentityTableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Indentity")
        myTableView.registerNib(UINib(nibName: "IdentityPicTableViewCell",bundle: nil), forCellReuseIdentifier: "picture")
        myTableView.registerNib(UINib(nibName: "IdentityPicTableViewCell",bundle: nil), forCellReuseIdentifier: "Driving")
        myTableView.separatorStyle = .None
        
        let bottom = UIView(frame: CGRectMake(0, 0, WIDTH, 120))
        let btn = UIButton(frame: CGRectMake(15, 30, WIDTH-30, 50))
        btn.layer.cornerRadius = 8
        btn.setTitle("下一步", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = COLOR
        btn.addTarget(self, action: #selector(self.nextToView), forControlEvents: .TouchUpInside)
        bottom.addSubview(btn)
        myTableView.tableFooterView = bottom

        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return 4
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 240
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return WIDTH*40/375
            }else if indexPath.row == 1 {
                return WIDTH*125/375
            }else{
                return WIDTH*135/375
            }
        }else{
            return WIDTH*135/375
        }
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }else{
            return 10
        }
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)as!IdentityTableViewCell
            cell.city.userInteractionEnabled = true
            //建立手势识别器
            let gesture = UITapGestureRecognizer(target: self, action: #selector(CertificationViewController.viewTap(_:)))
            //附加识别器到视图
            cell.city.addGestureRecognizer(gesture)
            cell.selectionStyle = .None
            let city = NSUserDefaults.standardUserDefaults()
            let cityName = city.objectForKey("city")
            if cityName==nil {
                
            }else{
               let string = cityName as? String
               let array:NSArray = (string?.componentsSeparatedByString("-"))!
               cell.city.text = array[1] as? String
               city.removeObjectForKey("city")
            }
            
            cell.cityChoose.addTarget(self, action: #selector(self.choseCity), forControlEvents:UIControlEvents.TouchUpInside)
            return cell
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("Indentity", forIndexPath: indexPath)
                cell.selectionStyle = .None
                cell.textLabel?.font = UIFont.systemFontOfSize(12)
                cell.textLabel?.textColor = UIColor(red: 1, green: 59/255.0, blue: 0, alpha: 1.0)
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "＊手持身份证正面照，靠近镜头正面拍摄胸部以上，保证身份证上面文字清晰可见"
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("picture", forIndexPath: indexPath)as!IdentityPicTableViewCell
                cell.selectionStyle = .None
                cell.Driving.setBackgroundImage(UIImage(named: "手持身份证"), forState: .Normal)
                cell.Camera.tag = indexPath.row
                cell.Camera.addTarget(self, action: #selector(self.goToCamera(_:)), forControlEvents: .TouchUpInside)
                return cell
            }else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCellWithIdentifier("picture", forIndexPath: indexPath)as!IdentityPicTableViewCell
                cell.selectionStyle = .None
                cell.Driving.setBackgroundImage(UIImage(named: "身份证正面"), forState: .Normal)
                cell.Camera.tag = indexPath.row
                cell.Camera.addTarget(self, action: #selector(CertificationViewController.goToCamera(_:)), forControlEvents: .TouchUpInside)
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("picture", forIndexPath: indexPath)as!IdentityPicTableViewCell
                cell.selectionStyle = .None
                cell.Driving.setBackgroundImage(UIImage(named: "驾照"), forState: .Normal)
                cell.Camera.tag = indexPath.row
                cell.Camera.addTarget(self, action: #selector(self.goToCamera(_:)), forControlEvents: .TouchUpInside)
                return cell
            }
        }

    }
    
    func viewTap(sender: UITapGestureRecognizer) {
        self.choseCity()
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 0{
//        
//        
//        }
//    }
    
    
    func choseCity(){
        
        let vc = ChoseCityViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
      
        
    }

    func goToCamera(btn:UIButton) {
        print(btn.tag)
        self.cellIndexpath = btn.tag
        
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
//        print("打开相机")
//        //                调用相机
//        dispatch_async(dispatch_get_main_queue(),{
//        if UIImagePickerController.isSourceTypeAvailable(.Camera){
//            //创建图片控制器
//            let picker = UIImagePickerController()
//            //设置代理
//            picker.delegate = self
//            //设置来源
//            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//            //允许编辑
//            picker.allowsEditing = true
//            //打开相机
////            if Float(UIDevice.currentDevice().systemVersion)>=8.0{
//               // self.modalPresentationStyle = .CurrentContext
////            }
//
//            self.presentViewController(picker, animated: true, completion: nil)
//            
////            self.presentViewController(picker, animated: true, completion: { () -> Void in
////                //如果有前置摄像头则调用前置摄像头
////                //                        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front){
////                //                            picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
////                //                        }
////                //开启闪光灯
////                //picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.On
////            })
//        }else{
//            print("找不到相机")
//        }
//    });
        
    }
    
    //代理方法
    func nextToView() {
        print("下一步")
        let city = self.view.viewWithTag(10) as? UILabel
        let name = self.view.viewWithTag(11) as? UITextField
        let presonId = self.view.viewWithTag(12) as? UITextField
        let emergency = self.view.viewWithTag(13) as? UITextField
        let emergencyPhone = self.view.viewWithTag(14) as? UITextField
        let view1 = self.view.viewWithTag(15) as? UIImageView
        let view2 = self.view.viewWithTag(16) as? UIImageView
        let view3 = self.view.viewWithTag(17) as? UIImageView

        print(city?.text)
        print(name?.text)
        print(presonId?.text)
        print(emergency?.text)
        print(emergencyPhone?.text)
        print(view1)
//        view2?.image
//        if name?.text==""||presonId?.text==""||emergency?.text==""||emergencyPhone?.text=="" {
//            print("请完善信息")
//        }else{
        array.addObject((city?.text)!)
        array.addObject((name?.text)!)
        array.addObject((presonId?.text)!)
        array.addObject((emergency?.text)!)
        array.addObject((emergencyPhone?.text)!)
//        array.addObject(data1)
//        array.addObject(data2)
//        array.addObject(data3)
        let userdefault = NSUserDefaults.standardUserDefaults()
        userdefault.setObject(array, forKey: "infomation")
//        let vc = SkillViewController()
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SkillView")
            self.navigationController?.pushViewController(vc, animated: true)
            vc.title = "技能选择"
//        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension CertificationViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let indexPath = NSIndexPath.init(forRow: self.cellIndexpath, inSection: 1)
        let cell = self.myTableView.cellForRowAtIndexPath(indexPath)as! IdentityPicTableViewCell
        let imageView = UIImageView()
        imageView.tag = 14+self.cellIndexpath
        imageView.frame = CGRectMake(0, 0, cell.Driving.frame.size.width, cell.Driving.frame.size.height)
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.view.addSubview(imageView)
        cell.Driving.addSubview(imageView)
        let data = UIImageJPEGRepresentation((info[UIImagePickerControllerEditedImage] as? UIImage)!, 0.1)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr = dateFormatter.stringFromDate(NSDate())
        let imageName = "avatar" + dateStr
        ConnectModel.uploadWithImageName(imageName, imageData: data, URL: "http://bang.xiaocool.net/index.php?g=apps&m=index&a=uploadimg") { [unowned self] (data) in
            dispatch_async(dispatch_get_main_queue(), {
                
                let result = Http(JSONDecoder(data))
                if result.status != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        if result.status! == "success"{
                            self.array.addObject(result.data!)
//                            self.imagenameArray.addObject(result.data!)
//                            self.imagename = result.data!
                            
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

        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
}

