//
//  LLToModelExtension.swift
//  LLProgramFramework.Swift
//
//  Created by 奥卡姆 on 2017/9/7.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import Foundation

import RxSwift
import Moya
import ObjectMapper



extension Observable{

    func mapObject<T:Mappable>(type: T.Type) -> Observable<T> {
        
        return self.map { response in
            
            guard let dict = response as? [String : Any] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().map(JSON: dict)!
        }
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }



