//
//  LLHomeViewModel.swift
//  LLProgramFramework.Swift
//
//  Created by 奥卡姆 on 2017/9/6.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import MJRefresh

enum LLRefreshStatus {
    case none
    case beginHeaderRefresh
    case endHeaderRefresh
    case beginFooterRefresh
    case endFooterRefresh
    case noMoreData
}

let cellID = "LLHomeCellID"

typealias ClosureType = (Int) -> Void

class LLHomeViewModel: NSObject {
    
    
    var bag : DisposeBag = DisposeBag()
    
    let provider = RxMoyaProvider<APIManager>()

    var modelObserable = Variable<[StoryModel]> ([])
    
    var refreshStateObserable = Variable<LLRefreshStatus>(.none)
    
    let requestNewDataCommond =  PublishSubject<Bool>()
    
    
    var pushCloure : ClosureType?
    
    var pageIndex = Int()
    
    var tableV = UITableView()
    
    func SetConfig() {
        
        tableV.register(UINib.init(nibName: "LLHomeCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        tableV.rowHeight = 80
        
        pageIndex = 0
        
        tableV.tableFooterView = UIView.init()
        
        //MARK: Rx 绑定tableView数据
        modelObserable.asObservable().bind(to: tableV.rx.items(cellIdentifier: cellID, cellType: LLHomeCell.self)){ row , model , cell in
            
            cell.titleLbl.text = model.title
            
            cell.imageV?.kf.setImage(with: URL.init(string: (model.images?.count)! > 0 ? (model.images?.first)! : ""))
            
            }.addDisposableTo(bag)
        
        tableV.rx.itemSelected.subscribe(onNext: { (index : IndexPath) in
            
            printLog("\(index.row)")
            
        }).addDisposableTo(bag)
        
        weak var weakSelf = self
        tableV.rx.modelSelected(StoryModel.self).subscribe(onNext: { (model : StoryModel) in
                        
            weakSelf?.pushCloure!(model.id!)
            
        }).addDisposableTo(bag)
        
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
                        LLProgressHUD.showSuccess("加载成功")
                    }, onError: { (error) in
                        self.refreshStateObserable.value = .endHeaderRefresh
                        LLProgressHUD.showError("加载失败")
                    }).addDisposableTo(self.bag)
            }else{
                //  假装请求第二页数据
                self.pageIndex += 1
                self.provider
                    .request(.GetHomeList)
                    .filterSuccessfulStatusCodes()
                    .mapJSON().mapObject(type: LLHomeModel.self).subscribe(onNext: { (model) in
                        LLProgressHUD.showSuccess("加载成功")
                        self.modelObserable.value += model.stories!
                        self.refreshStateObserable.value = self.pageIndex > 3 ? .noMoreData : .endFooterRefresh
                    }, onError: { (error) in
                        self.refreshStateObserable.value = .endFooterRefresh
                        LLProgressHUD.showError("加载失败")
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







