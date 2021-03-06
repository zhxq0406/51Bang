//
//  SkillModel.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/6/28.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import Foundation
//typealias ResponseBlock = (success:Bool,response:AnyObject?)->Void

class SkillListModel: JSONJoy{
        var status:String?
        var data: JSONDecoder?
        var datas = Array<SkillModel>()
        var errorData:String?
        init(){
        }
        required init(_ decoder:JSONDecoder){
            
            status = decoder["status"].string
            if status == "success" {
                for childs: JSONDecoder in decoder["data"].array!{
                    print(childs)
                    print(SkillModel(childs))
                    datas.append(SkillModel(childs))
                    print(datas)
//                    array.append(SkillModel(childs))
                }
            }else{
                errorData = decoder["data"].string
            }
            
        }
    }
    
class SkillModel: JSONJoy {
    var id:String?
    var name:String?
    var photo:String?
    var parent:String?
    var listorder:String?
    var clist:[ClistInfo]
    init(){
        
        clist = Array<ClistInfo>()
    }
    
    required init(_ decoder: JSONDecoder){
        
        id = decoder["id"].string
        name = decoder["name"].string
        photo = decoder["photo"].string
        parent = decoder["parent"].string
        listorder = decoder["listorder"].string
        clist = Array<ClistInfo>()
        if decoder["clist"].array != nil {
            for childs: JSONDecoder in decoder["clist"].array!{
                self.clist.append(ClistInfo(childs))
            }
        }
    }
    func addpend(list: [ClistInfo]){
        self.clist = list + self.clist
    }
    
    }

//
//class SkillInfo: JSONJoy{
//        var id:String?
//        var name:String?
//        var photo:String?
//        var parent:String?
//        var listorder:String?
//        var clist:[ClistInfo]
//        init(){
//    
//            clist = Array<ClistInfo>()
//        }
//    
//        required init(_ decoder: JSONDecoder){
//    
//            id = decoder["id"].string
//            name = decoder["name"].string
//            photo = decoder["photo"].string
//            parent = decoder["parent"].string
//            listorder = decoder["listorder"].string
//            clist = Array<ClistInfo>()
//            if decoder["clist"].array != nil {
//                for childs: JSONDecoder in decoder["clist"].array!{
//                    self.clist.append(ClistInfo(childs))
//                }
//            }
//    }
//     func addpend(list: [ClistInfo]){
//            self.clist = list + self.clist
//        }
//        
//    }

class ClistList: JSONJoy {
        var status:String?
        var objectlist: [ClistInfo]
        
        var count: Int{
            return self.objectlist.count
        }
        init(){
            objectlist = Array<ClistInfo>()
        }
        required init(_ decoder: JSONDecoder) {
            
            objectlist = Array<ClistInfo>()
            for childs: JSONDecoder in decoder.array!{
                objectlist.append(ClistInfo(childs))
            }
        }
        
        func append(list: [ClistInfo]){
            self.objectlist = list + self.objectlist
        }
        
    }
    
    
    
class ClistInfo: JSONJoy {
        
    
        var id:String?
        var name:String?
        var photo:String?
        var parent:String?
        var listorder:String?
    
        init() {
    
        }
        required init(_ decoder: JSONDecoder){
    
            id = decoder["id"].string
            name = decoder["name"].string
            photo = decoder["photo"].string
            parent = decoder["parent"].string
            listorder = decoder["listorder"].string
            
        }
        
}




