//
//  LLHomeViewController.swift
//  LLProgramFramework.Swift
//
//  Created by 奥卡姆 on 2017/9/5.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class LLHomeViewController: LLBaseViewController {
    
    var bag : DisposeBag = DisposeBag()
    
    var provider = RxMoyaProvider<APIManager>()
    
    let viewModel = LLHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabV = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        view.addSubview(tabV)
        viewModel.tableV = tabV;
        viewModel.GetData()
        loadData()
    }

}


extension LLHomeViewController{

    func loadData() {
                                
    provider
        .request(.GetHomeList)
        .filterSuccessfulStatusCodes()
        .mapJSON().mapObject(type: LLHomeModel.self).subscribe(onNext: { (model) in
            
            self.viewModel.modelObserable.value = model.stories!
            
        }, onError: { (error) in
            
        }).addDisposableTo(bag)
        

    }
    
    func loadMoreData(){

    }

}





