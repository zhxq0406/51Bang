//
//  PayViewController.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/6.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class PayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let myTableView = UITableView()
    var selectArr = NSMutableArray()
    var payMode = NSString()
    var isAgree = Bool()
    /**
     *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
     */
     let WXAppId = "wx765b8c5e082532b4";
    
    /**
     *  申请微信支付成功后，发给你的邮件里的微信支付商户号
     */
    let WXPartnerId = "1364047302";
    
    /** API密钥 去微信商户平台设置--->账户设置--->API安全， 参与签名使用 */
    //risF2owP8yAdmZgfVYnmqZoElIpD5Bz1
    //risF2owP8yAdmZgfVYnmqZoElIpD5Bz1
    let WXAPIKey = "risF2owP8yAdmZgfVYnmqZoElIpD5Bz1";
    
    /** 获取prePayId的url, 这是官方给的接口 */
    let getPrePayIdUrl = "https://api.mch.weixin.qq.com/pay/unifiedorder";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAgree = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(self.nextView(_:)),
                                                         name: "payResult", object: nil)
        self.navigationController?.title = "订单支付"
        self.createTableView()
        // Do any additional setup after loading the view.
    }
    func createTableView(){
        myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        myTableView.backgroundColor = RGREY
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerNib(UINib(nibName: "PayMethodTableViewCell",bundle: nil), forCellReuseIdentifier: "paycell")
        let bottom = UIView(frame: CGRectMake(0, HEIGHT-330, WIDTH, 150))
        let label = UILabel.init(frame: CGRectMake(WIDTH-160, 0, 160, 22))
        label.text = "我同意《51帮托管协议》"
        label.textColor = UIColor.grayColor()
        label.font = UIFont.systemFontOfSize(14)
        let selectBtn = UIButton.init(frame: CGRectMake(WIDTH-185, 0, 17, 17))
        selectBtn.tag = 15
        selectBtn.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
        selectBtn.addTarget(self, action: #selector(self.agreePro), forControlEvents: UIControlEvents.TouchUpInside)
//        imageView.image = UIImage(named: "ic_weixuanze")
        let btn = UIButton(frame: CGRectMake(15, 80, WIDTH-30, 50))
        btn.layer.cornerRadius = 8
        btn.setTitle("立即支付", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = COLOR
        btn.addTarget(self, action: #selector(self.pay), forControlEvents: .TouchUpInside)
        bottom.addSubview(label)
        bottom.addSubview(selectBtn)
        bottom.addSubview(btn)

        let headerView =  NSBundle.mainBundle().loadNibNamed("PayHeaderCell", owner: nil, options: nil).first as? PayHeaderCell
        headerView?.frame = CGRectMake(0, 0, WIDTH, 100)
        view.backgroundColor = RGREY
        myTableView.tableHeaderView = headerView
        self.view.addSubview(myTableView)
        self.view.addSubview(bottom)
    }
    
    
    //支付方法
    func pay(){
        print(self.payMode)
        if self.payMode.isEqualToString("") {
            alert("请选择支付方式", delegate: self)
            print("请选择支付方式")
            return
        }else if self.payMode == "支付宝"{
            //支付宝支付
            let userDufault = NSUserDefaults.standardUserDefaults()
            let orderNum = userDufault.objectForKey("ordernumber") as! String
            print(orderNum)
            let partner = "2088002084967422";
            let seller = "aqian2001@163.com ";
            let privateKey = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAK4a3fO2l5Jn82ywtsBmWCKUDz/J0KKqmEXgu2VjO98dMjN7C+eO48kmhEe7JFpwVYZ9+tuO3TsSDonJ1DOsxVY/341/zYr8tV3SPjhChPTObAswUXznQ8qChIP8sCLdakw/YnlxnOvJneztmg++bIlMIGZUZy17rMKCgHTloJ7LAgMBAAECgYBv/RIlUJ7AaqL2l9iFe49Xdps0cbEE4OyfjgWcGq+JPTNsT8qBgLTeTyspJKQmlDk/EEvK7GM7OsslMDCRqKEpYGqgMJDZGYwanUc/gP4PNarsYY9J7yckRNMoUL2X8ROatiHLv2gHhaQ8zqQf0xG9/9uz+RG9KBiOhQzhEb7DmQJBAN40brXMEJdqqAxQ/de80M1vhgSu5nG+d/ztF2JHG/00DlUGu4AWypPL/6Xys5/GaWWCX3/XawZSHeias9NHdS0CQQDIlalKdsuFKSmrtH24hc/fYOp2VsWFUmMSDBzcizytT+zVKs1CBUbk5R7Pg/PS5iyeqYR6fbvs0HuArkD/f87XAkAQPLqeVEQeHHAdPkneWvDTIkQj0XgLdcSk2dpslw+niAdIFU7cRE4XUL/kq4COu1v2S/mYiPBMLPH8jll3pfAdAkAwhGLKbCmWL/qwWZv/Qf6h3WNY9Gwab28fMmbYwaUPlsGGXi//xB79xp3JO/WCEcLBLeepaThHc7YrzfpS0qtJAkEArxp4t06xxjWRKHpZdDFdtzpEdYg0sIDRhfepVCKxI496HRlrlo+7WipncI4Pm5fJIvm0IXbTlmlIVJx8EYKPPA=="
            //let privateKey = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAL9MUaZqnb8XrhMxURZmhnhPN8JsgWURnAkOoqdiZZZl6IqXyhWqldFTCACDZt/j8gcfCt7PFTjshD13i+jm1VoRexEntVU1cn5qQ06lnCEOmBDQX1VEP1lzpYYqvbWiUtqzLxDloVpkgArlrzJB0mScwNE1AaChZ1i01ULH+uB1AgMBAAECgYAL15SiYa08PCIJjB8B7PzcC8Ne5Mqp0ApBwUcuZ3f0dICNu9HFv5agq6wuI/RFXd4ItNI+csFUkcep6nGdzFResIWzcyrSypHN8o8Cue2Yov5yjA7Fu4MEjTsy/hI9ch78GP+bfA4Ovx9Z+e1BWMMhgoNoBPoxgg1zld54sC5N7QJBAO7nVEOY+6q8n6tLTEmQHGjxJWpWyairYf40UV4n2aJrlJMCeuWXnKrsC5lUYvYljTpB+eEg2AQZ8ADKGzdfFCMCQQDM/N2V6V3vIRveJKqnPiXNBYlfAk/FLVxXW90yux6MVrI36y7aBGPbpXhO3TjMj1spZP/QbPaJTU4+a4mVFtaHAkEAjnwbrqFcYA1VsYUcP7eaqiBA73ZJmbZ1oHY1nVFpJMzC9RcCk1JkVzCnDlDdIO9ulrNoxBOhoniRwvbHWrPzPwJAbr2Iw+0f5wje8kKiwtkLONht3xrzl1UrFrK1LCv0k+JeQ2FVnUhT3hxlg0112uTzXciHfsTu5zwRMh2MZTPCTwJBAMXMksxezoK4wPEscWwEwzEJRB7bklVEMpcOf4QR90HQAFRH4bDffISI4RUc8I8FLMCGdDzkNFoI4LdwE9hGeZI="
            let order = Order()
            order.partner = partner;
            order.sellerID = seller;
            order.outTradeNO = orderNum; //订单ID（由商家自行制定）
            order.subject = "测试"; //商品标题
            order.body = "这是测试商品"; //商品描述
            order.totalFee = "0.01"; //商品价格
            order.notifyURL =  "http://bang.xiaocool.net/api/alipay_app/notify_url.php"; //回调URL，这个URL是在支付之后，支付宝通知后台服务器，使数据同步更新，必须填，不然支付无法成功
            //下面的参数是固定的，不需要改变
            order.service = "mobile.securitypay.pay";
            order.paymentType = "1";
            order.inputCharset = "utf-8";
            order.itBPay = "30m";
            order.showURL = "m.alipay.com";
            
            //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
            let appScheme = "51bang";
            let orderSpec = order.description;
            
            let signer = CreateRSADataSigner(privateKey);
            let signedString = signer.signString(orderSpec);
            if signedString != nil {
                let orderString = "\(orderSpec)&sign=\"\(signedString)\"&sign_type=\"RSA\"";
//                AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (resultDic)->Void in
//                    print("reslut = \(resultDic)");
//                    if let Alipayjson = resultDic as? NSDictionary{
//                        let resultStatus = Alipayjson.valueForKey("resultStatus") as! String
//                        if resultStatus == "9000"{
//                            print("OK")
//                            let vc = OrderDetailViewController()
//                            self.navigationController?.pushViewController(vc, animated: true)
//                        }else if resultStatus == "8000" {
//                            print("正在处理中")
//                            self.navigationController?.popViewControllerAnimated(true)
//                        }else if resultStatus == "4000" {
//                            print("订单支付失败");
//                            self.navigationController?.popViewControllerAnimated(true)
//                        }else if resultStatus == "6001" {
//                            print("用户中途取消")
//                            self.navigationController?.popViewControllerAnimated(true)
//                        }else if resultStatus == "6002" {
//                            print("网络连接出错")
//                            self.navigationController?.popViewControllerAnimated(true)
//                        }
//                    }
//                })
                
                
                AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme) { (dic)-> Void in
                    print(dic)
                    
                    let vc = OrderDetailViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }else{
        //微信支付
            print("微信支付")
//            WXApi.registerApp:"wxd930ea5d5a258f4f" withDescription:"demo 2.0"
           
            self.getWeChatPayWithOrderName("我的订单", price: "1")

           
        }
        
    
    
    }
    
    func nextView(notification: NSNotification){
    
        let vc = OrderDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    func getWeChatPayWithOrderName(name:NSString,price:NSString){
    
        let userDufault = NSUserDefaults.standardUserDefaults()
        let orderNum = userDufault.objectForKey("ordernumber") as! String
        print(orderNum)
        
        //----------------------------获取prePayId配置------------------------------
        // 订单标题，展示给用户
        let orderName = name
        // 订单金额,单位（分）, 1是0.01元
        let orderPrice = price
        // 支付类型，固定为APP
        let orderType = "APP"
        // 随机数串
        let noncestr  = CommonUtil.genNonceStr()
        // 商户订单号
        let orderNO   = CommonUtil.genOutTradNo()
        //ip
        let ipString = CommonUtil.getIPAddress(true)
        
        //================================
        //预付单参数订单设置
        //================================
        let  packageParams = NSMutableDictionary()
        packageParams.setObject(WXAppId, forKey: "appid")       //开放平台appid
        packageParams.setObject(WXPartnerId, forKey: "mch_id")  //商户号
        packageParams.setObject(noncestr, forKey: "nonce_str")   //随机串
        packageParams.setObject(orderType, forKey: "trade_type") //支付类型，固定为APP
        packageParams.setObject(orderName, forKey: "body")       //订单描述，展示给用户
        packageParams.setObject(orderNum, forKey: "out_trade_no") //商户订单号
        packageParams.setObject(orderPrice, forKey: "total_fee") //订单金额，单位为分
        packageParams.setObject(ipString, forKey: "spbill_create_ip") //发器支付的机器ip
        packageParams.setObject("http://bang.xiaocool.net/api/alipay_app/notify_url.php", forKey: "notify_url") //支付结果异步通知
        var prePayid = NSString()
        prePayid = CommonUtil.sendPrepay(packageParams,andUrl: getPrePayIdUrl)
        //---------------------------获取prePayId结束------------------------------
        if prePayid != ""{
            let timeStamp = CommonUtil.genTimeStamp()//时间戳
            let request = PayReq.init()
            request.partnerId = WXPartnerId
            request.prepayId = prePayid as String
            request.package = "Sign=WXPay"
            request.nonceStr = noncestr
            print(timeStamp)
            print(UInt32((timeStamp as NSString).intValue))
            request.timeStamp = UInt32((timeStamp as NSString).intValue)
            // 这里要注意key里的值一定要填对， 微信官方给的参数名是错误的，不是第二个字母大写
            let signParams = NSMutableDictionary()
            signParams.setObject(WXAppId, forKey: "appid")
            signParams.setObject(WXPartnerId, forKey: "partnerid")
            signParams.setObject(noncestr, forKey: "noncestr")
            signParams.setObject(timeStamp, forKey: "timestamp")
            signParams.setObject(prePayid as String, forKey: "prepayid")
            signParams.setObject(orderName, forKey: "body")
            signParams.setObject("Sign=WXPay", forKey: "package")
            //生成签名
//            let sign = CommonUtil.genSign(signParams as [NSObject : AnyObject])
            let md5 = DataMD5.init()
            let sign1 = md5.createMd5Sign(signParams)
            //let sign1 = md5.createMD5SingForPay(WXAppId, partnerid:WXPartnerId , prepayid: request.prepayId, package: request.package, noncestr: noncestr, timestamp: request.timeStamp)
            //添加签名
            request.sign = sign1
            print(request)
            WXApi.sendReq(request)
        }else{
        
            print("获取prePayID失败")
        }
      
        
    }
    
    //微信支付回调方法
    func onResp(resp:BaseResp){
    
        if resp.isKindOfClass(PayResp) {
            let strTitle = "支付结果"
            let strMsg = resp.errCode as! String
//            UIAlertView.init(title: strTitle, message: strMsg, delegate: self, cancelButtonTitle: "OK", otherButtonTitles: nil)
            let alert = UIAlertView.init(title: strTitle, message: strMsg, delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.separatorStyle = .None
        let cell = tableView.dequeueReusableCellWithIdentifier("paycell")as! PayMethodTableViewCell
        cell.selectionStyle = .None
        cell.selectButton.tag = indexPath.row
        cell.tag = indexPath.row
        cell.selectButton.addTarget(self, action: #selector(self.onClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        if indexPath.row == 0 {
            cell.title.text = "支付宝"
        }else{
        
            cell.title.text = "微信"
            cell.iconImage.image = UIImage(named: "ic_weixin")
            cell.desc.text = "推荐安装微信5.0及以上版本的使用"
            cell.bottomView.removeFromSuperview()
        }
       return cell
    
    }
    
    func agreePro(){
    
        let button = self.view.viewWithTag(15)as! UIButton
        if isAgree == false {
            
            button.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
            isAgree = true
        }else{
            button.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
            isAgree = false
        }
    
    }
    
    func onClick(btn:UIButton){
    
        
        let indexPath = NSIndexPath.init(forRow: btn.tag , inSection: 0)
        let cell = self.myTableView.cellForRowAtIndexPath(indexPath)as! PayMethodTableViewCell
        if selectArr.count == 0{
            cell.selectButton.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
            selectArr.addObject(cell.selectButton)
            self.payMode = cell.title.text!
            print(selectArr)
        }else{
            for btn in selectArr {
                if btn as! NSObject == cell.selectButton  {
                    cell.selectButton.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
                    selectArr.removeObject(cell.selectButton)
                     print(selectArr)
                }else{
                
                    for btn in selectArr {
                        btn.setImage(UIImage(named: "ic_weixuanze"), forState: UIControlState.Normal)
                        selectArr.removeObject(btn)
                    }
                    cell.selectButton.setImage(UIImage(named: "ic_xuanze"), forState: UIControlState.Normal)
                    selectArr.addObject(cell.selectButton)
                    self.payMode = cell.title.text!
                    print(selectArr)
                }
            }
        }
        
    }
    
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let headerView =  NSBundle.mainBundle().loadNibNamed("PayHeaderCell", owner: nil, options: nil).first as? PayHeaderCell
//        view.backgroundColor = RGREY
//        return headerView
//
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
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
