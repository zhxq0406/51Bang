//
//  MainHelper.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/6.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire

class MainHelper: NSObject {

    func getTaskList(userid:String,cityName:String,longitude:String,latitude:String,handle:ResponseBlock){
        let url = Bang_URL_Header+"getTaskListByCity"
//                let param = [
//                    "userid":"1",
//                    "city":"北京",
//                    "longitude":"110.23121",
//                    "latitude":"12.888"
//                ];
        let param1 = [
        
            "userid":userid,
            "city":cityName,
            "longitude":longitude,
            "latitude":latitude
        
        ];
        Alamofire.request(.GET, url, parameters: param1).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = TaskModel(JSONDecoder(json!))
                print("---")
                print(result)
                print("---")
                //let status = SkillListModel(JSONDecoder(json!))
                if(result.status == "success"){
                    print(result.datas)
                    print(result.datas.count)
                    handle(success: true, response: result.datas)
                    
                    
                }else{
                    handle(success: false, response: result.errorData)
                    
                }
            }
            
        }
    }

    //发布任务
    func upLoadOrder(userid:String,title:String,description:String,address:String,longitude:String,latitude:String,expirydate:String,price:String,handle:ResponseBlock){
        let url = Bang_URL_Header+"publishTask"
        let param = [
            "userid":"1",
            "title":"找人取快递",
            "description":"找人取快递找人取快递找人取快递找人取快递",
            "address":address,
            "longitude":longitude,
            "latitude":latitude,
            "type":"2",
            "price":"200"
        ];
        let param1 = [
            
            "userid":userid,
            "title":title,
            "description":description,
            "address":address,
            "longitude":longitude,
            "latitude":latitude,
            "price":price
        ];
        Alamofire.request(.GET, url, parameters: param1).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = Http(JSONDecoder(json!))
                print("---")
                print(result)
                print("---")
                //let status = SkillListModel(JSONDecoder(json!))
                if(result.status == "success"){
                    print(result.data)
                    handle(success: true, response: result.data)
                    
                }else{
//                    handle(success: false, response: result.errorData)
                    
                }
            }
            
        }
    }
    
    
    //发布便民信息
    func upLoadMessage(userid:NSString,type:NSString,title:NSString,content:NSString,photoArray:NSArray,handle:ResponseBlock){
       let url = Bang_URL_Header+"addbbsposts"
        let photoUrl = NSMutableString()
        for i in 0..<photoArray.count {
            if i == photoArray.count-1{
                photoUrl.appendString(photoArray[i] as! String)
            }else{
                photoUrl.appendString(photoArray[i] as! String)
                photoUrl.appendString(",")
            }
//            photoUrl.appendString(photoArray[i] as! String)
//            photoUrl.appendString(",")
//            if i==photoArray.count-1 {
////                photoUrl.delete(",")
//                photoUrl.deleteCharactersInRange(NSRange.init(location: i, length: 1))
//            }
        }
        print(photoUrl)
        let param = [
            
            "userid":userid,
            "title":title,
            "content":content,
            "picurl":photoUrl
        ];
        
        
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = Http(JSONDecoder(json!))
                print("---")
                print(result)
                print("---")
                //let status = SkillListModel(JSONDecoder(json!))
                if(result.status == "success"){
                    print(result.data)
                    handle(success: true, response: result.data)
                    
                }else{
                    //                    handle(success: false, response: result.errorData)
                    
                }
            }
    
      }
  }
    
    func GetTchdList(type:NSString,handle:ResponseBlock){
        let url = Bang_URL_Header+"getbbspostlist"
        let param = [
            
          "type":type
        ];
        
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = TchdModel(JSONDecoder(json!))
                print("---")
                print(result)
                print("---")
                //let status = SkillListModel(JSONDecoder(json!))
                if(result.status == "success"){
                    print(result.datas)
                    handle(success: true, response: result.datas)
                    
                }else{
                    //                    handle(success: false, response: result.errorData)
                    
                }
            }
            
        }
        
    }
    
    
    func GetRzbList(handle:ResponseBlock){
        
        // url	String	"http://bang.xiaocool.net/index.php?g=apps&m=index&a=getAuthenticationUserList"
        let url = Bang_URL_Header+"getAuthenticationUserList"
        
        Alamofire.request(.GET, url, parameters: nil).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = RzbModel(JSONDecoder(json!))
                print("---")
                print(result)
                print("---")
                //let status = SkillListModel(JSONDecoder(json!))
                if(result.status == "success"){
                    print(result.datas)
                    handle(success: true, response: result.datas)
                    
                }else{
                    handle(success: false, response: result.errorData)
                    
                }
            }
            
        }
        
        
    }
    
    func GetTaskList(userid:NSString,state:NSString,handle:ResponseBlock){
         let url = Bang_URL_Header+"getTaskListByUserid"
        let param = [
            "userid":userid,
            "state":state
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = TaskModel(JSONDecoder(json!))
                print("---")
                print(result)
                print("---")
                //let status = SkillListModel(JSONDecoder(json!))
                if(result.status == "success"){
                    print(result.datas)
                    print(result.datas.count)
                    handle(success: true, response: result.datas)
                    
                    
                }else{
                    handle(success: false, response: result.errorData)
                    
                }
            }
            
        }


    
    }

    func qiangDan(userid:NSString,taskid:NSString,longitude:NSString,latitude:NSString,handle:ResponseBlock){
        let url = Bang_URL_Header+"ApplyTask"
        let param = [
            "userid":userid,
            "taskid":taskid,
            "longitude":longitude,
            "latitude":latitude
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = Http(JSONDecoder(json!))
                print("---")
                print(result)
                print("---")
                //let status = SkillListModel(JSONDecoder(json!))
                if(result.status == "success"){
                    print(result.data)
                    
                    handle(success: true, response: result.data)
                    
                    
                }else{
                    handle(success: false, response: result.errorData)
                    
                }
            }
            
        }

    
    }
    
    
    
}
