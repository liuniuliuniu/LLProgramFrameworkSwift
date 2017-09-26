//
//  LLRequestPlugin.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/26.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import Foundation
import Moya
import Result


let netWorkActivityPlugin = NetworkActivityPlugin { (change) -> () in

    switch(change){
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}


 public final class LLRequestPlugin: PluginType {
    
    /// Called immediately before a request is sent over the network (or stubbed).
    public func willSend(_ request: RequestType, target: TargetType) {
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {                
        switch result {
            case .success(let response):
                let json:Dictionary? = try! JSONSerialization.jsonObject(with: response.data,                                                                     options:.allowFragments) as! [String: Any]
                print(json as Any)
                LLProgressHUD.showSuccess("加载成功")
            case .failure:
                LLProgressHUD.showError("加载失败")
                break
        }
        
    }
}










