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
    
    
    let viewModel = LLHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabV = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        view.addSubview(tabV)
        viewModel.tableV = tabV;
        viewModel.GetData()
        
        
        weak var weakself = self
        viewModel.pushCloure = { ( id : Int) in
            
        }
        
    }
}




