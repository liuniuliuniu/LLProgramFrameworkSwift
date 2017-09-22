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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //MARK:NAV高度
        let NAVMargin = isX() ? 88 : 64
        //MARK:TABBAR高度
        let TABBARMargin = isX() ? 34 : 0
        
        let tabV = UITableView.init(frame: CGRect.init(x: 0, y: CGFloat(NAVMargin), width: LLSCREENW, height: LLSCREENH - CGFloat(NAVMargin + TABBARMargin)), style: UITableViewStyle.plain)
        if #available(iOS 11.0, *) {
            tabV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior(rawValue: 2)!
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        };
        
        
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








