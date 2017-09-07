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

class LLHomeViewModel: NSObject {
    
    var bag : DisposeBag = DisposeBag()
    
    private let provider = RxMoyaProvider<APIManager>()
        
    let dispose = DisposeBag()        

    var modelObserable = Variable<[StoryModel]> ([])
    
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
        
        
        tableV.rx.modelSelected(StoryModel.self).subscribe(onNext: { (model : StoryModel) in
            
            print(model.image ?? "")
            
        }).addDisposableTo(bag)
        
    }    
}
