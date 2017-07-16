//
//  RxViewModel.swift
//  LLRxSwift
//
//  Created by liushaohua on 2017/7/16.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

import UIKit
import RxSwift

class RxViewModel {
    
    var modelObserable : Variable<[RxModel]> = {
        
        var models : [RxModel] = [RxModel]()
        
        for i in 0..<20 {            
            let model = RxModel()
            model.name = "我是小\(i)"
            models.append(model)
        }
        
        return Variable(models)
        
    }()
    

}
