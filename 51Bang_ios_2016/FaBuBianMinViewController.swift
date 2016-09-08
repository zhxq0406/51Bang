//
//  FaBuBianMinViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/7.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import AVFoundation

var type = Int()
class FaBuBianMinViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var isRecord = Bool()
   
    let headerView = UIView()
    let photoArray = NSMutableArray()
    let myTableViw = UITableView()
    var collectionV:UICollectionView?
    let photoNameArr = NSMutableArray()
    let mainHelper = MainHelper()
    private let GET_ID_KEY = "record"
    var processHandle:TimerHandle?
    var finishHandle:TimerHandle?
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    let timeButton = UIButton()
    ////定义音频的编码参数，这部分比较重要，决定录制音频文件的格式、音质、容量大小等，建议采用AAC的编码方式
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),//声音采样率
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),//编码格式
        AVNumberOfChannelsKey : NSNumber(int: 1),//采集音轨
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]//音频质量

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = 0
        isRecord = false
        myTableViw.frame = CGRectMake(0, 0, WIDTH, HEIGHT-30)
        myTableViw.delegate = self
        myTableViw.dataSource = self
        myTableViw.backgroundColor = RGREY
        myTableViw.registerNib(UINib(nibName: "LianXiDianHuaTableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        //myTableViw.registerNib(UINib(nibName: "LianXiDianHuaTableViewCell",bundle: nil), forCellWithReuseIdentifier: "cell")
        //myTableViw.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let view = UIView()
        self.myTableViw.tableFooterView = view
        self.view.addSubview(myTableViw)
        
        self.createTextView()
        time()
        
//        textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89)
        self.navigationController?.title = "发布便民信息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发布", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.fabu))
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                                                settings: recordSettings)//初始化实例
            audioRecorder.prepareToRecord()//准备录音
        } catch {
        }
        TimeManager.shareManager.taskDic[GET_ID_KEY]?.FHandle = finishHandle
        TimeManager.shareManager.taskDic[GET_ID_KEY]?.PHandle = processHandle
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        TimeManager.shareManager.taskDic[GET_ID_KEY]?.FHandle = nil
        TimeManager.shareManager.taskDic[GET_ID_KEY]?.PHandle = nil
    }
    
    func directoryURL() -> NSURL? {
        //定义并构建一个url来保存音频，音频文件名为ddMMyyyyHHmmss.caf
        //根据时间来设置存储文件名
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".caf"
        print(recordingName)
        
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent(recordingName)
        print(soundURL)
        return soundURL
    }
    
    
    func createTextView(){
        headerView.frame = CGRectMake(0, 0, WIDTH, WIDTH*220/375)
//        headerView.backgroundColor = UIColor.greenColor()
        let textView = PlaceholderTextView.init(frame: CGRectMake(0, 0, WIDTH, WIDTH*200/375))
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
        button.addTarget(self, action: #selector(self.goToCamera(_:)), forControlEvents: .TouchUpInside)
        let yinPin = UIButton.init(frame: CGRectMake(80, textView.frame.size.height-30, 30, 30))
        yinPin.setImage(UIImage(named: "ic_yinpin"), forState: UIControlState.Normal)
        yinPin.addTarget(self, action: #selector(self.startRecord), forControlEvents: UIControlEvents.TouchUpInside)
        let shiPin = UIButton.init(frame: CGRectMake(140, textView.frame.size.height-30, 30, 30))
        shiPin.setImage(UIImage(named: "ic_shipin"), forState: UIControlState.Normal)
        
        textView.addSubview(button)
        textView.addSubview(yinPin)
//        textView.addSubview(shiPin)
        let line = UILabel.init(frame: CGRectMake(0, button.frame.size.height+button.frame.origin.y+10, WIDTH, 1))
        line.backgroundColor = RGREY
        headerView.addSubview(textView)
        headerView.addSubview(line)
        self.myTableViw.tableHeaderView = headerView
//        myTableViw.tableHeaderView = textView
//        self.view.addSubview(textView)
    }
    
    //录音
    func startRecord(){
 
        if isRecord == false {
             //开始录音
            if !audioRecorder.recording {
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    
                    TimeManager.shareManager.begainTimerWithKey(self.GET_ID_KEY, timeInterval: 60, process: self.processHandle!, finish: self.finishHandle!)
                    self.view.addSubview(self.timeButton)
                    try audioSession.setActive(true)
                    audioRecorder.record()
                    print(audioRecorder.currentTime)
                    print("record!")
                } catch {
                }
            }
            isRecord = true
        }else if isRecord == true{
            //停止录音
            audioRecorder.stop()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setActive(false)
                print("stop!!")
                self.timeButton.removeFromSuperview()
//                TimeManager.shareManager
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
                print(audioPlayer.duration)
                
                let image = UIImage.init(named: "ic_yinpinbeijing-1")
                self.photoArray.addObject(image!)
                type = 1
                self.addCollectionViewPicture()
            
                isRecord = false
            } catch {
            }
            
        }
    
    }
    
    func time(){
        
        processHandle = {[unowned self] (timeInterVal) in
            dispatch_async(dispatch_get_main_queue(), {
                
                self.timeButton.frame = CGRectMake(WIDTH/2-50, 200, 100, 100)
                self.timeButton.backgroundColor = UIColor.grayColor()
                self.timeButton.layer.cornerRadius = 50
                self.timeButton.alpha = 0.6
                print(String(timeInterVal))
                self.timeButton.setTitle(String(timeInterVal), forState: UIControlState.Normal)
//                self.view.addSubview(self.timeButton)
//                self.checkNumBtn.userInteractionEnabled = false
//                let btnTitle = String(timeInterVal) + "秒后重新获取"
//                self.checkNumBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
//                self.checkNumBtn.setTitleColor(COLOR, forState: .Normal)
//                
//                self.checkNumBtn.setTitle(btnTitle, forState: .Normal)
                
                
                
            })
        }
        
        finishHandle = {[unowned self] (timeInterVal) in
            dispatch_async(dispatch_get_main_queue(), {
                
                self.timeButton.removeFromSuperview()
                self.isRecord = false
//                self.checkNumBtn.userInteractionEnabled = true
//                self.checkNumBtn.setTitleColor(COLOR, forState: .Normal)
//                self.checkNumBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
//                self.checkNumBtn.setTitle("获取验证码", forState: .Normal)
            })
        }
        TimeManager.shareManager.taskDic["forget"]?.FHandle = finishHandle
        TimeManager.shareManager.taskDic["forget"]?.PHandle = processHandle
    }

    
    
    
    func goToCamera(btn:UIButton){
    
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
    //MARK:创建图片视图
    func addCollectionViewPicture(){
    
        let flowl = UICollectionViewFlowLayout.init()
        //设置每一个item大小
    
        flowl.itemSize = CGSizeMake((WIDTH-60)/3, (WIDTH-60)/3)
//        flowl.sectionInset = UIEdgeInsetsMake(<#T##top: CGFloat##CGFloat#>, <#T##left: CGFloat##CGFloat#>, <#T##bottom: CGFloat##CGFloat#>, <#T##right: CGFloat##CGFloat#>)
        flowl.sectionInset = UIEdgeInsetsMake(10, 10, 5, 10)
        flowl.minimumInteritemSpacing = 10
        flowl.minimumLineSpacing = 10
        print(self.photoArray.count)
        var height =  CGFloat(((self.photoArray.count-1)/3))*((WIDTH-60)/3+10)+((WIDTH-60)/3+10)+10
        if self.photoArray.count == 0 {
            height = 0
        }
        //创建集合视图
        self.collectionV = UICollectionView.init(frame: CGRectMake(0, WIDTH*210/375, WIDTH, height), collectionViewLayout: flowl)
        collectionV!.backgroundColor = UIColor.whiteColor()
        collectionV!.delegate = self
        collectionV!.dataSource = self
//        collectionV?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "photo")
        collectionV!.registerNib(UINib(nibName: "PhotoCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "photo")
        collectionV!.registerNib(UINib(nibName: "SoundCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "yinpin")
        self.headerView.addSubview(collectionV!)
        self.headerView.frame.size.height = WIDTH*210/375+(collectionV?.frame.size.height)!
        self.myTableViw.tableHeaderView = self.headerView

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

        cell.button.setBackgroundImage(self.photoArray[indexPath.item] as? UIImage, forState: UIControlState.Normal)
//        cell.myImage.image = self.photoArray[indexPath.item] as? UIImage
        if type == 1 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("yinpin", forIndexPath: indexPath)as! SoundCollectionViewCell
//            try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
            print(audioPlayer.duration)
            cell.myButton.setTitle(String(audioPlayer.duration), forState: UIControlState.Normal)
            cell.myButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            cell.myButton.frame = CGRectMake(0, 0, cell.frame.size.width, 30)
//            cell.button.frame.size.height = 30
//            cell.myButton.backgroundColor = UIColor.redColor()
//            cell.button.center = cell.center
            cell.frame.size.height = 35
        }
        let button = UIButton.init(frame: CGRectMake(cell.frame.size.width-20, 0, 20, 20))
        button.setImage(UIImage(named: "ic_shanchu-cha"), forState: UIControlState.Normal)
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(self.deleteImage(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSubview(button)
//        cell.myImage.addSubview(button)
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")as! LianXiDianHuaTableViewCell
        cell.phone.borderStyle = .None
        return cell
    }
    
    //MARK:发布便民信息
    func fabu(){
        print("发布便民信息")
        
        let textView = self.view.viewWithTag(1)as! PlaceholderTextView
        print(textView.text)
        if textView.text == "" {
            let aletView = UIAlertView.init(title: "提示", message:"请填写相关信息", delegate: self, cancelButtonTitle: "确定")
            aletView.show()
        }else{
            let ud = NSUserDefaults.standardUserDefaults()
            let userid = ud.objectForKey("userid")as! String
            print(userid)
            mainHelper.upLoadMessage(userid, type: "1", title: textView.text, content: textView.text, photoArray: self.photoNameArr) { (success, response) in
                print(response)
                let aletView = UIAlertView.init(title: "提示", message:"正在审核,请稍等", delegate: self, cancelButtonTitle: "确定")
                aletView.show()
                
            }
        
        }

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
