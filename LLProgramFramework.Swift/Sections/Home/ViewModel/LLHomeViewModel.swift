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

let cellID = "LLHomeCellID"

typealias ClosureType = (Int) -> Void

class LLHomeViewModel: NSObject {
    

    var bag : DisposeBag = DisposeBag()
    
    private let provider = RxMoyaProvider<APIManager>()
        
    let dispose = DisposeBag()        

    var modelObserable = Variable<[StoryModel]> ([])
    
    var pushCloure : ClosureType?
    
    var tableV = UITableView()
    
    func GetData() {
        
        tableV.register(UINib.init(nibName: "LLHomeCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        tableV.rowHeight = 80
        
        tableV.tableFooterView = UIView.init()
        
                
        //MARK: Rx 绑定tableView数据
        modelObserable.asObservable().bind(to: tableV.rx.items(cellIdentifier: cellID, cellType: LLHomeCell.self)){ row , model , cell in
            
            cell.titleLbl.text = model.title
            
            cell.imageV?.kf.setImage(with: URL.init(string: (model.images?.count)! > 0 ? (model.images?.first)! : ""))
            
            }.addDisposableTo(bag)
        
        
        tableV.rx.itemSelected.subscribe(onNext: { (index : IndexPath) in
            
            print("\(index.row)")            
            
        }).addDisposableTo(bag)
        
        
        
        weak var weakSelf = self
        tableV.rx.modelSelected(StoryModel.self).subscribe(onNext: { (model : StoryModel) in
                        
            weakSelf?.pushCloure!(model.id!)
            
        }).addDisposableTo(bag)
        
        
        // 请求数据
        provider
            .request(.GetHomeList)
            .filterSuccessfulStatusCodes()
            .mapJSON().mapObject(type: LLHomeModel.self).subscribe(onNext: { (model) in
                
                self.modelObserable.value = model.stories!
                
            }, onError: { (error) in
                
            }).addDisposableTo(bag)
        
    }
    
    
    
}
