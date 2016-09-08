//
//  ShopHelper.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/4.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire

class ShopHelper: NSObject {
    
    func getGoodsList(handle:ResponseBlock){
        let url = Bang_URL_Header+"getshoppinglist"
//        let param = [
//            "id":"0"
//        ];
        Alamofire.request(.GET, url, parameters: nil).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = GoodsModel(JSONDecoder(json!))
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
    
    //发布特卖
    func upLoadTeMaiMessage(userid:NSString,type:NSString,goodsname:NSString,oprice:NSString,price:NSString,desc:NSString,photoArray:NSArray,unit:NSString,handle:ResponseBlock){
        print(goodsname)
        print(photoArray)
        let url = Bang_URL_Header+"PublishGoods"
        let photoUrl = NSMutableString()
        for i in 0..<photoArray.count {
            if i == photoArray.count-1{
                photoUrl.appendString(photoArray[i] as! String)
            }else{
                photoUrl.appendString(photoArray[i] as! String)
                photoUrl.appendString(",")
            }

        }
        print(photoUrl)
        let param = [
            
            "userid":userid,
            "type":type,
            "goodsname":goodsname,
            "oprice":oprice,
            "price":price,
            "picture":photoUrl,
            "description":desc,
            "unit":unit
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

    //收藏商品
    
    func favorite(userid:NSString,type:NSString,goodsid:NSString,title:NSString,desc:NSString,handle:ResponseBlock){
        let url = Bang_URL_Header+"addfavorite"
        let param = [
            
            "userid":userid,
            "goodsid":goodsid,
            "type":type,
            "title":title,
            "description":desc,
           
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
    
     func cancelFavoritefunc(userid:NSString,type:NSString,goodsid:NSString,handle:ResponseBlock){
        let url = Bang_URL_Header+"cancelfavorite"
        let param = [
            
            "userid":userid,
            "goodsid":goodsid,
            "type":type
            
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
    
    //获取我的发布
    
    func getMyFaBu(userid:NSString,handle:ResponseBlock){
        //http://bang.xiaocool.net/index.php?g=apps&m=index&a=getMyshoppinglist
        let url = Bang_URL_Header+"getMyshoppinglist"
        let param = [
            
            "userid":userid
            
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            print(request)
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let result = GoodsModel(JSONDecoder(json!))
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

    
    
    
    
    
    

}