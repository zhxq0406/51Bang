//
//  TCVMLogModel.swift
//  Parking
//
//  Created by xiaocool on 16/5/10.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire

typealias ResponseBlock = (success:Bool,response:AnyObject?)->Void

class TCVMLogModel: NSObject {
    var requestManager:AFHTTPSessionManager?
    
    override init() {
        super.init()
        requestManager = AFHTTPSessionManager()
        requestManager?.responseSerializer = AFHTTPResponseSerializer()
    }
    //登录
    func login(phoneNum:String,password:String,handle:ResponseBlock){
        let url = Bang_URL_Header+"applogin"
        let paramDic = ["phone":phoneNum,"password":password]
        Alamofire.request(.GET, url, parameters: paramDic).response { request, response, json, error in
            print(request)
             let result = TCUserInfoModel(JSONDecoder(json!))
             print(result)
             print(result.data)
             print(result.status)
             if result.status == "success"{
                print(result.data)
                handle(success: true, response: result.data)
             }else{
                handle(success: false, response: result.data)
                print(result.data)
                
            }
 
            
        }
        
//        requestManager?.GET(url, parameters: paramDic, success: { (task, response) in
//            let result = TCUserInfoModel(JSONDecoder(response!))
//            if result.status == "success"{
//                TCUserInfo.currentInfo.phoneNumber = (result.data?.user_phone)!
//                let userid = (result.data?.id)!
//                TCUserInfo.currentInfo.userid = String(userid)
//                TCUserInfo.currentInfo.userName = (result.data?.user_name)!
//                TCUserInfo.currentInfo.address = (result.data?.addr)!
//                TCUserInfo.currentInfo.cardid = (result.data?.card_id)!
//                TCUserInfo.currentInfo.bankNo = (result.data?.bank_branch)!
//                TCUserInfo.currentInfo.banktype = (result.data?.bank_type)!
//                TCUserInfo.currentInfo.bankBranch = (result.data?.bank_no)!
//                TCUserInfo.currentInfo.bankUserName = (result.data?.bank_user_name)!
//                TCUserInfo.currentInfo.sex = (result.data?.sex)!
//                if result.data?.avatar != nil {
//                    TCUserInfo.currentInfo.avatar = (result.data?.avatar)!
//                }
//            }
//            let responseStr = result.status == "success" ? nil : result.errorData
//                handle(success: result.status == "success",response: responseStr)
//            }, failure: { (task, error) in
//                handle(success: false,response: "网络错误")
//        })
    }
    //发送验证码
    func sendMobileCodeWithPhoneNumber(phoneNumber:String){
        let url = Bang_URL_Header+"SendMobileCode"
        let paramDic = ["phone":phoneNumber]
        requestManager?.GET(url, parameters: paramDic, success: { (task, obj) in
            }, failure: { (task, error) in})
    }
    //注册
    func register(phone:String,password:String,
                  code:String,avatar:String,name:String,
                sex:String,cardid:String,addr:String, handle:ResponseBlock){
        let url = Bang_URL_Header+"AppRegister"
        let paramDic = ["phone":phone,"password":password,
                        "code":code,"name":name,"devicestate":"1"
                       ]
        requestManager?.GET(url, parameters: paramDic, success: { (task, response) in
            let result = Http(JSONDecoder(response!))
            let responseStr = result.status == "success" ? nil : result.errorData
            handle(success: result.status == "success",response: responseStr)
            }, failure: { (task, error) in
                handle(success: false,response: "网络错误")
        })
    }
    //忘记密码
    func forgetPassword(phone:String,code:String,password:String,handle:ResponseBlock){
        let url = Bang_URL_Header+"forgetpwd"
        let paramDic = ["phone":phone,"code":code,"password":password]
        requestManager?.GET(url, parameters: paramDic, success: { (task, response) in
            let result = Http(JSONDecoder(response!))
            let responseStr = result.status == "success" ? "成功" : result.errorData
            if responseStr != nil {
                handle(success: result.status == "success",response: responseStr)
            }
            }, failure: { (task, error) in
                handle(success: false,response: "网络错误")
        })
    }
    //验证手机是否已经注册
    func comfirmPhoneHasRegister(phoneNum:String,handle:ResponseBlock){
        let url = Bang_URL_Header+"checkphone"
        let paraDic = ["phone":phoneNum]
        requestManager?.GET(url, parameters: paraDic, success: { (task, response) in
            let result = Http(JSONDecoder(response!))
            let responseStr = result.status == "success" ? nil : result.errorData
            handle(success: result.status == "success",response: responseStr)
            }, failure: { (task, error) in
               handle(success: false,response: "网络错误") 
        })
    }
    
    func getCollectionList(uid:NSString,handle:ResponseBlock){
    //http://bang.xiaocool.net/index.php?g=apps&m=index&a=getfavoritelist&userid=578
        
        let url = Bang_URL_Header+"getfavoritelist"
        let paramDic = ["userid":uid]
        Alamofire.request(.GET, url, parameters: paramDic).response { request, response, json, error in
            print(request)
            let result = CollectionModel(JSONDecoder(json!))
            print(result)
            print(result.data)
            print(result.status)
            if result.status == "success"{
                print(result.datas)
                handle(success: true, response: result.datas)
            }else{
                
                print(result.data)
            }
            
            
        }
    
    }
    
    
    
    
    func ChangePhone(userid:NSString,phone:NSString,code:NSString,handle:ResponseBlock){
        let url = Bang_URL_Header+"UpdateUserPhone"
        let paramDic = ["userid":userid,"phone":phone,"code":code]
        Alamofire.request(.GET, url, parameters: paramDic).response { request, response, json, error in
            print(request)
            let result = Http(JSONDecoder(response!))
            print(result)
            print(result.data)
            print(result.status)
            if result.status == "success"{
                print(result.data)
                handle(success: true, response: result.data)
            }else{
                alert(result.data!, delegate: self)
                print(result.data)
            }
            
            
        }
    }

    
    
}
