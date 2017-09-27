//
//  LLHomeViewModel.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/6.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Alamofire
import MJRefresh

let cellID = "LLHomeCellID"


enum LLRefreshStatus {
    case none
    case beginHeaderRefresh
    case endHeaderRefresh
    case beginFooterRefresh
    case endFooterRefresh
    case noMoreData
}


public func defaultAlamofireManager() -> Manager {
    
    let configuration = URLSessionConfiguration.default
    
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    
    let policies: [String: ServerTrustPolicy] = [
        "ap.grtstar.cn": .disableEvaluation
    ]
    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
    
    manager.startRequestsImmediately = false
    
    return manager
}


private func endpointMapping<Target: TargetType>(target: Target) -> Endpoint<Target> {
    
    print("请求连接：\(target.baseURL)\(target.path) \n方法：\(target.method)\n参数：\(String(describing: target.parameters)) ")
    
    return MoyaProvider.defaultEndpointMapping(for: target)
}


class LLHomeViewModel: NSObject {
    
    var bag : DisposeBag = DisposeBag()
    
    let provider = RxMoyaProvider<APIManager>(endpointClosure: endpointMapping, manager: defaultAlamofireManager(), plugins: [LLRequestPlugin(),netWorkActivityPlugin])
    
    var modelObserable = Variable<[StoryModel]> ([])
    
    var refreshStateObserable = Variable<LLRefreshStatus>(.none)
    
    let requestNewDataCommond =  PublishSubject<Bool>()
        
    var pageIndex = Int()
    
    var tableV = UITableView()
    
    func SetConfig() {
        
        //MARK: Rx 绑定tableView数据
        modelObserable.asObservable()
            .bind(to: tableV.rx.items(cellIdentifier: cellID, cellType: LLHomeCell.self)){ row , model , cell in
                
            cell.titleLbl.text = model.title
            cell.imageV?.kf.setImage(with: URL.init(string: (model.images?.count)! > 0 ? (model.images?.first)! : ""))
                
            }
            .addDisposableTo(bag)
        
        
        requestNewDataCommond.subscribe { (event : Event<Bool>) in
            if event.element! {
                // 假装在请求第一页
                self.pageIndex = 0
                self.provider
                    .request(.GetHomeList)
                    .filterSuccessfulStatusCodes()
                    .mapJSON().mapObject(type: LLHomeModel.self).subscribe(onNext: { (model) in
                        self.modelObserable.value = model.stories!
                        self.refreshStateObserable.value = .endHeaderRefresh

                    }, onError: { (error) in
                        self.refreshStateObserable.value = .endHeaderRefresh
                    }).addDisposableTo(self.bag)
            }else{
                //  假装请求第二页数据
                self.pageIndex += 1
                self.provider
                    .request(.GetHomeList)
                    .filterSuccessfulStatusCodes()
                    .mapJSON().mapObject(type: LLHomeModel.self).subscribe(onNext: { (model) in

                        self.modelObserable.value += model.stories!
                        self.refreshStateObserable.value = self.pageIndex > 3 ? .noMoreData : .endFooterRefresh
                    }, onError: { (error) in
                        self.refreshStateObserable.value = .endFooterRefresh
                    }).addDisposableTo(self.bag)
            
            }
        }.addDisposableTo(bag)
        
        
        refreshStateObserable.asObservable().subscribe(onNext: { (state) in
            switch state{
            case .beginHeaderRefresh:
                self.tableV.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self.tableV.mj_header.endRefreshing()
                self.tableV.mj_footer.resetNoMoreData()
            case .beginFooterRefresh:
                self.tableV.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self.tableV.mj_footer.endRefreshing()
            case .noMoreData:
                self.tableV.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).addDisposableTo(bag)
    }
}







