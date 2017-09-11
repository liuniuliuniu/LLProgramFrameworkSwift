//
//  APIManager.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/7.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import Foundation
import Moya

enum APIManager{
    case GetHomeList // 获取首页列表
    case GetHomeDetail(Int)  // 获取详情页

}

extension APIManager: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "http://news-at.zhihu.com/api/")!
    }
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
            
        case .GetHomeList: // 不带参数的请求
            return "4/news/latest"
        case .GetHomeDetail(let id):  // 带参数的请求
            return "4/theme/\(id)"
        }
    }
    
    var method: Moya.Method {        
        return .get
    }
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        return nil
    }
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }


}
