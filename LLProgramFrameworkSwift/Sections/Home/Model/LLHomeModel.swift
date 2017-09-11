//
//  LLHomeModel.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/6.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import Foundation
import ObjectMapper


class LLHomeModel: Mappable {
    
    var date: String?
    var stories: [StoryModel]?
    var top_stories: [StoryModel]?
            
    //  接下来的两个方法是必须要实现的
    required init?(map: Map) {
        
    }
    
    //
    public func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
        top_stories <- map["top_stories"]
    }
    
}



class StoryModel: Mappable {
    var ga_prefix: String?
    var id: Int?
    var images: [String]?
    var title: String?
    var type: Int?
    var image: String?
    var multipic = false
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        images <- map["images"]
        title <- map["title"]
        type <- map["type"]
        image <- map["image"]
        multipic <- map["multipic"]
        
    }
    
    
    
}
