//
//  AddViewController.swift
//  51Bang_ios_2016
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import SVProgressHUD

class AddViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
   
    let headerView = UIView()
    let mytableView = UITableView()
    let leftTableView = UITableView()
    let rightTableView = UITableView()
    let mytextView = UITextField()//商品名称
    var isShow = Bool()
    let coverView = UIView()
    let photoArray = NSMutableArray()
    var collectionV:UICollectionView?
    let photoNameArr = NSMutableArray()
    let shopHelper = ShopHelper()
    let leftArr = ["全部分类","餐饮美食","休闲娱乐","个护化妆","餐饮美食","休闲娱乐","个护化妆"]
    let rightArr = ["全部","足疗按摩","运动健身","KTV","其他养生保健","游乐园","其他游乐活动"]
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        mytableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        mytableView.backgroundColor = RGREY
        mytableView.dataSource = self
        mytableView.delegate = self
        mytableView.tag = 0
        mytableView.registerNib(UINib(nibName: "FabuTableViewCell4",bundle: nil), forCellReuseIdentifier: "cell4")
        mytableView.registerNib(UINib(nibName: "FabuTableViewCell1",bundle: nil), forCellReuseIdentifier: "cell1")
        
        mytableView.registerNib(UINib(nibName: "FabuTableViewCell2",bundle: nil), forCellReuseIdentifier: "cell2")
        
        mytableView.registerNib(UINib(nibName: "FabuTableViewCell3",bundle: nil), forCellReuseIdentifier: "cell3")
        
        mytableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.view.addSubview(mytextView)
        let bottom = UIView(frame: CGRectMake(0, 0, WIDTH, 120))
        let btn = UIButton(frame: CGRectMake(15, 30, WIDTH-30, 50))
        btn.layer.cornerRadius = 8
        btn.setTitle("发布", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = COLOR
        //btn.addTarget(self, action: #selector(self.fabu), forControlEvents: <#T##UIControlEvents#>)
        btn.addTarget(self, action: #selector(self.fabu), forControlEvents: .TouchUpInside)
        bottom.addSubview(btn)
        mytableView.tableFooterView = bottom
        self.view.addSubview(mytableView)
        self.createTextView()
        // Do any additional setup after loading the view.
    }
    
    
    func keyboardWillShow(note:NSNotification){
        
        let userInfo  = note.userInfo as! NSDictionary
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let deltaY = keyBoardBounds.size.height
        
        UIView.animateWithDuration(0.4, animations: {
            self.mytableView.frame.origin.y = -deltaY
        })
        
    }
    
    func keyboardWillHide(note:NSNotification){
        
        UIView.animateWithDuration(0.4, animations: {
            self.mytableView.frame.origin.y = 0
        })
        
    }
    
    
    
    func fabu(){
        
//        if loginSign == 0 {//未登陆
//            
//            self.tabBarController?.selectedIndex = 3
//            
//        }else{
            //已登陆
            let ud = NSUserDefaults.standardUserDefaults()
            let userid = ud.objectForKey("userid")as! String
            let textView = self.view.viewWithTag(1)as! PlaceholderTextView
            let price = self.view.viewWithTag(5)as! UITextField
            print(mytextView.text!)
            print(textView.text)
            print(price.text!)
            print(self.photoNameArr)
            shopHelper.upLoadTeMaiMessage(userid, type: "1", goodsname:self.mytextView.text!, oprice: "50", price: price.text!, desc: textView.text, photoArray: self.photoNameArr, unit: "") { (success, response) in
                print(response)
            }
//        }
   
    }
    
    func createTextView(){
        headerView.frame = CGRectMake(0, 0, WIDTH, 250)
//                headerView.backgroundColor = UIColor.greenColor()
        
        mytextView.frame = CGRectMake(10, 0, WIDTH, 60)
        mytextView.placeholder = "特卖商品名称"
        
        let textView = PlaceholderTextView.init(frame: CGRectMake(0, 60, WIDTH, 180))
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
        let line = UILabel.init(frame: CGRectMake(0, button.frame.size.height+button.frame.origin.y+10, WIDTH, 1))
        line.backgroundColor = RGREY
        headerView.addSubview(mytextView)
        headerView.addSubview(textView)
//        headerView.addSubview(line)
        self.mytableView.tableHeaderView = headerView
        //        myTableViw.tableHeaderView = textView
        //        self.view.addSubview(textView)
    }
    
    
    func viewTap(sender: UITapGestureRecognizer) {
        print("clicked...")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return 3
        }else if tableView.tag == 1{
        
            return self.leftArr.count
        }else{
        
            return rightArr.count
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
             if indexPath.row == 0{
                
                let cell = mytableView.dequeueReusableCellWithIdentifier("cell1")as! FabuTableViewCell1
                cell.title.text = "分类"
                cell.selectionStyle = .None
                tableView.separatorStyle = .None
                //cell.button.addTarget(self, action: #selector(self.goToCamera(_:)), forControlEvents: .TouchUpInside)
                cell.button.addTarget(self, action: #selector(self.onClick), forControlEvents: .TouchUpInside)
                //            cell.accessoryType = .DisclosureIndicator
                return cell
            }else if indexPath.row == 1{
                let cell = mytableView.dequeueReusableCellWithIdentifier("cell2")as! FabuTableViewCell2
                cell.title.text = "价格"
                cell.textField.tag = 5
                cell.selectionStyle = .None
                cell.textField.borderStyle = .None
                tableView.separatorStyle = .None
                return cell
            }else{
                let cell = mytableView.dequeueReusableCellWithIdentifier("cell2")as! FabuTableViewCell2
                cell.title.text = "位置"
                cell.textField.borderStyle = .None
                print(address)
                if address == "" {
                    //SVProgressHUD.showSuccessWithStatus("登录成功")
                    alert("请打开定位服务",delegate:self)
                }else{
                    cell.textField.text = address
                }
                
                cell.textField.placeholder = ""
                cell.selectionStyle = .None
                tableView.separatorStyle = .None
                //            cell.accessoryType = .DisclosureIndicator
                return cell
            }

        }else if tableView.tag == 1 {
            tableView.separatorStyle = .None
            let cell = tableView.dequeueReusableCellWithIdentifier("leftTableView")
            cell?.textLabel?.text = leftArr[indexPath.row]
            return cell!
        }else{
            tableView.separatorStyle = .None
            let cell = tableView.dequeueReusableCellWithIdentifier("rightTableView")
            cell?.textLabel?.text = rightArr[indexPath.row]
            cell?.backgroundColor = UIColor.grayColor()
            return cell!
        }
      
       
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 2 {
            coverView.removeFromSuperview()
            leftTableView.removeFromSuperview()
            rightTableView.removeFromSuperview()
        }else if tableView.tag == 0{
        
            print(indexPath.row)
        }
    }
    
    
    func onClick(){
        coverView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-48)
        coverView.backgroundColor = UIColor.grayColor()
        coverView.alpha = 0.8
        leftTableView.frame = CGRectMake(0, 0, WIDTH/2, HEIGHT/2)
        leftTableView.tag = 1
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "leftTableView")
        //        view.addSubview(leftTableView)
        leftTableView.backgroundColor = UIColor.whiteColor()
        rightTableView.frame = CGRectMake(WIDTH/2, 0, WIDTH/2, leftTableView.frame.size.height)
        rightTableView.backgroundColor = UIColor.grayColor()
        rightTableView.tag = 2
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "rightTableView")
        self.view.addSubview(leftTableView)
        self.view.addSubview(rightTableView)
        self.view.addSubview(coverView)
        self.view.bringSubviewToFront(leftTableView)
        self.view.bringSubviewToFront(rightTableView)
        
    
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
        self.collectionV = UICollectionView.init(frame: CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, WIDTH, height), collectionViewLayout: flowl)
        collectionV!.backgroundColor = UIColor.whiteColor()
        collectionV!.delegate = self
        collectionV!.dataSource = self
        //        collectionV?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "photo")
        collectionV!.registerNib(UINib(nibName: "PhotoCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "photo")
        self.headerView.addSubview(collectionV!)
        self.headerView.frame.size.height = 210+(collectionV?.frame.size.height)!
        self.mytableView.tableHeaderView = self.headerView
        
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
        self.collectionV?.reloadData()
        if self.photoArray.count == 0 {
            self.collectionV?.frame.size.height = 0
            self.collectionV?.removeFromSuperview()
            self.addCollectionViewPicture()
        }
        
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
