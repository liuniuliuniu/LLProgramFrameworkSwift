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
import MJRefresh

class LLHomeViewController: LLBaseViewController {
        
    let viewModel = LLHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabV = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        view.addSubview(tabV)
        viewModel.tableV = tabV;
        viewModel.SetConfig()
        
        weak var weakself = self
        
        tabV.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakself?.viewModel.requestNewDataCommond.onNext(true)
        })
        
        tabV.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            weakself?.viewModel.requestNewDataCommond.onNext(false)
        })
        
        tabV.mj_header.beginRefreshing()
                
        viewModel.pushCloure = { ( id : Int) in
        
        }
        
    }
}




