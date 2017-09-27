//
//  LLHomeViewController.swift
//  LLProgramFrameworkSwift
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
    
    var tableView = UITableView()
    
    var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        setupUI()
        
        tableViewAction()
        
    }
    
    fileprivate  func setupUI() {
    
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: CGFloat(NAVMargin), width: LLSCREENW, height: LLSCREENH - CGFloat(NAVMargin + TABBARMargin)), style: UITableViewStyle.plain)
        
        tableView.register(UINib.init(nibName: "LLHomeCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        tableView.rowHeight = 80
        
        tableView.tableFooterView = UIView.init()
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior(rawValue: 2)!
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        };
        
        view.addSubview(tableView)
        
        viewModel.tableV = tableView
        
        viewModel.SetConfig()
        
        weak var weakself = self
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakself?.viewModel.requestNewDataCommond.onNext(true)
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            weakself?.viewModel.requestNewDataCommond.onNext(false)
        })
        
        tableView.mj_header.beginRefreshing()        
    }
    
    fileprivate func tableViewAction() {
    
        tableView.rx
            .itemSelected
            .subscribe(onNext: {
                (index : IndexPath) in
                printLog("\(index.row)")
            })
            .addDisposableTo(bag)
        
        tableView.rx
            .modelSelected(StoryModel.self)
            .subscribe(
                onNext:{
                    value in
                    printLog(value.title)
            })
            .addDisposableTo(bag)
        
    }
    
    
    
}








