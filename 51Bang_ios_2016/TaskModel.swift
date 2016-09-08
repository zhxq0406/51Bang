//
//  TaskModel.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/6.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

class TaskModel: NSObject {
    var status:String?
    var data: JSONDecoder?
    //    var datas ＝ Array<GoodsList>()
    var datas = Array<TaskInfo>()
    var errorData:String?
    override init(){
    }
    required init(_ decoder:JSONDecoder){
        
        status = decoder["status"].string
        if status == "success" {
            for childs: JSONDecoder in decoder["data"].array!{
//                print(childs)
//                print(SkillModel(childs))
                datas.append(TaskInfo(childs))
                print(datas)
                //                    array.append(SkillModel(childs))
            }
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class TaskList: JSONJoy {
    var status:String?
    var objectlist: [TaskInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<TaskInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<TaskInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(TaskInfo(childs))
        }
    }
    
    func append(list: [TaskInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class TaskInfo: JSONJoy {
    
    var id:String?
    var userid:String?
    var title:String?
    var price:String?
    var type:String?
    var description:String?
    var time:String?
    var longitude:String?
    var latitude:String?
    var expirydate:String?
    var address:String?
    var order_num:String?
    var status:String?
    var phone:String?
    var name:String?
    
    init(){
        
    }
    required init(_ decoder: JSONDecoder){
        
        id = decoder["id"].string
        price = decoder["price"].string
        description = decoder["description"].string
        userid = decoder["userid"].string
        title = decoder["title"].string
        type = decoder["type"].string
        time = decoder["time"].string
        longitude = decoder["longitude"].string
        latitude = decoder["latitude"].string
        expirydate = decoder["expirydate"].string
        address = decoder["address"].string
        order_num = decoder["order_num"].string
        status = decoder["status"].string
        phone = decoder["phone"].string
        name = decoder["name"].string
    }
    
}

