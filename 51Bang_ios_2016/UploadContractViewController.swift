//
//  UploadContractViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/2.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class UploadContractViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "上传合同"
        self.view.backgroundColor = RGREY
        button.frame = CGRectMake(10, 10, 100, 100)
//        button.setTitle("上传合同", forState: UIControlState.Normal)
        button.setImage(UIImage(named: "ic_shangchuanhetong-0"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState:UIControlState.Normal)
        button.addTarget(self, action: #selector(self.upload), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        let button2 = UIButton.init(frame: CGRectMake(10, HEIGHT-140, WIDTH/2-20, 40))
        button2.setTitle("跳过", forState: UIControlState.Normal)
        button2.addTarget(self, action: #selector(self.tiaoguo), forControlEvents: UIControlEvents.TouchUpInside)
        let button3 = UIButton.init(frame: CGRectMake(WIDTH/2+10, HEIGHT-140, WIDTH/2-20, 40))
        button2.layer.cornerRadius = 5
        button3.layer.cornerRadius = 5
        button3.setTitle("上传", forState: UIControlState.Normal)
        button2.backgroundColor = UIColor.orangeColor()
        button3.backgroundColor = COLOR
        button3.addTarget(self, action: #selector(self.tiaoguo), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        // Do any additional setup after loading the view.
    }

    func tiaoguo(){
        let vc = PayViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    //上传合同
    func upload(){
      
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        self.button.setImage(info[UIImagePickerControllerEditedImage] as? UIImage, forState: UIControlState.Normal)
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
                            print(result.data)
//                            self.array.addObject(result.data!)
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

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.hidden = false
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
