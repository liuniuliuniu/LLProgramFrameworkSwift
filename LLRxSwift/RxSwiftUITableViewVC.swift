//
//  RxSwift-UITableViewVC.swift
//  LLRxSwift
//
//  Created by liushaohua on 2017/7/16.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let cellID = "cellID"

class RxSwiftUITableViewVC: UIViewController {
    
    
    var tableView = UITableView()
    
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    fileprivate var modelArr : [RxModel]?
    
    let viewModel = RxViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.创建UITableView(跟OC几乎一样)
        let tabV = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView = tabV
        
        
        //2.注册Cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        //下面这种写法也是可以的
//        3.设置数据源和代理
//        tableView.dataSource = self
//        tableView.delegate = self;
        
        //4.添加到view中
        self.view.addSubview(tableView)
        
        
        //  负责数据绑定
        viewModel.modelObserable.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: cellID,
                 cellType: UITableViewCell.self)){ row, model, cell in
                 cell.textLabel?.text = model.name
        }.addDisposableTo(bag)
        
        
        // 监听点击cell 获取index
        tabV.rx.itemSelected.subscribe(onNext: { (index : IndexPath) in
            
//            点击cell就刷新数据
//            self.reloadData()
            
        }).addDisposableTo(bag)
        
        // 监听点击cell 获取Model
        tabV.rx.modelSelected(RxModel.self).subscribe(onNext: { (model : RxModel) in
            
            print(model.name)
            
        }).addDisposableTo(bag)
        
        
        
        /*
         viewModel.modelObserable.asObservable().subscribe(onNext: { (models : [RxModel]) in
         
         self.modelArr = models
         
         self.tableView.reloadData()
         
         }).addDisposableTo(bag)
         
         */

        
    }
    
}


extension RxSwiftUITableViewVC{
    
    func reloadData() {
        
        let model = RxModel()
        model.name = "奥卡姆剃须刀"
        // 刷新数据只需更改 modelObserable 的Value
        viewModel.modelObserable.value = [model]
    }
}



/*
 原始的方法：  
 VC太臃肿
 
 
 

extension RxSwiftUITableViewVC{
    
    fileprivate func loadData(){
    
        tableView.reloadData()
        
    }
}

extension RxSwiftUITableViewVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let model = models[indexPath.row]
        
        cell.textLabel?.text = model.name
                
        return cell
    }
    
}
    

*/



