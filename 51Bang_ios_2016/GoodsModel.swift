//
//  GoodsModel.swift
//  51Bang_ios_2016
//
//  Created by zhang on 16/7/4.
//  Copyright © 2016年 校酷网络科技公司. All rights reserved.
//

import UIKit

//typealias ResponseBlock = (success:Bool,response:AnyObject?)->Void

class GoodsModel: JSONJoy {
    var status:String?
    var data: JSONDecoder?
//    var datas ＝ Array<GoodsList>()
    var datas = Array<GoodsInfo>()
    var errorData:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        
        status = decoder["status"].string
        if status == "success" {
            for childs: JSONDecoder in decoder["data"].array!{
                print(childs)
                print(SkillModel(childs))
                datas.append(GoodsInfo(childs))
                print(datas)
                //                    array.append(SkillModel(childs))
            }
        }else{
            errorData = decoder["data"].string
        }
        
    }
    
}
class GoodsList: JSONJoy {
    var status:String?
    var objectlist: [GoodsInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<GoodsInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<GoodsInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(GoodsInfo(childs))
        }
    }
    
    func append(list: [GoodsInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class GoodsInfo: JSONJoy {
    
    var id:String?
    var goodsname:String?
    var price:String?
    var picture:String?
    var description:String?
    init(){
        
    }
    required init(_ decoder: JSONDecoder){
        
        id = decoder["id"].string
        goodsname = decoder["goodsname"].string
        price = decoder["price"].string
        description = decoder["description"].string
        picture = decoder["picture"].string
    }
    
}












