//
//  LLToModelExtension.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/7.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import Foundation

import RxSwift
import Moya
import ObjectMapper



extension Observable{

    //
    func mapObject<T:Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            guard let dict = response as? [String : Any] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            return Mapper<T>().map(JSON: dict)!
        }
    }
        
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            //if response is an array of dictionaries, then use ObjectMapper to map the dictionary
            //if not, throw an error
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }

    
    
    
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }



