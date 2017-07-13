//
//  ViewController.swift
//  LLRxSwift
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var textFlied: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var scrollV: UIScrollView!
    
    // 懒加载  为了消除RxSwift的警告
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        // 1 创建一个naver的obserable 从来不执行
        let neverO = Observable<String>.never()
        neverO.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        
        // 2 创建一个empty的Obserable 只能发出一个complete事件
        let empty = Observable<String>.empty()

        empty.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        
        // 3 just 是创建一个sequence只能发出一种特定的事件 能正常结束
        let just = Observable.just("10")
        just.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        // 4 of 创建一个sequence 能发出很多事件信号
        let of = Observable.of("a","b","c")
        of.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        // 5 From 就是从数组中创建sequence
        let from = Observable.from(["1","2","3"])
        from.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        // 6 create 创建一个自定义的disposable  实际开发中常用的  会在自定义很多事件来监听的
        let create = createObserable()
        create.subscribe { (event : Event<Any>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        //  自定义事件
        let myJust = myJustObservable(element: "奥卡姆剃须刀")
        
        myJust.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        // 7 range  这个作用不是很大
        let range = Observable.range(start: 1, count: 10)
        range.subscribe { (event : Event<Int>) in
            print(event)
        }.addDisposableTo(bag)
 
        // 8 重复
        let repeatLL = Observable.repeatElement("奥卡姆剃须刀")
        // 重复次数
        repeatLL.take(5).subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        
    }
    
}



extension ViewController{
    
    func createObserable() -> Observable<Any> {
        
        return Observable.create({ (observer : AnyObserver<Any>) -> Disposable in
            
            observer.onNext("奥卡姆剃须刀")
            observer.onNext("18")
            observer.onNext("65")
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
    
    // 自定义just
    func myJustObservable(element:String) -> Observable<String> {
        
        return Observable.create({ (observer : AnyObserver<String>) -> Disposable in
            
            observer.onNext(element)
            
            observer.onCompleted()
            
            return Disposables.create()
            
        })
        
        
    
    }
    
    
    
    
    
    
    

    @objc fileprivate   func getName() {
        print("123")
    }
    
    
    
    @objc fileprivate   func kvoDemo() {
        
        //        4 KVO 传统的做法
        //        lbl.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        
        
        // RX的监听
        label.rx.observe(String.self, "text").subscribe(onNext: { (str : String?) in
            
            print(str!)
            
        }).addDisposableTo(bag)
        
        label.rx.observe(CGRect.self, "frame").subscribe(onNext: { (frame : CGRect?) in
            
            print(frame!)
            
        }).addDisposableTo(bag)
        
        
        //        5 监听UIScrollView 的滚动
        scrollV.contentSize = CGSize(width: 1000, height: 0)
        
        scrollV.rx.contentOffset.subscribe(onNext: { (point : CGPoint) in
            print(point)
        }).addDisposableTo(bag)
        
    }
    
    //    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    //        print((change?[NSKeyValueChangeKey.newKey])!)
    //    }

    
    
    @objc fileprivate   func bindDemo() {
        
        // 3 将我们的TextFiled的内容显示在Lable中  老套的做法
        textFlied.rx.text.subscribe(onNext: { (str : String?) in
            self.label.text = str!
            
        }).addDisposableTo(bag)
        
        //  RxSwift推荐的做法 .bind(to: <#T##ObserverType#>) observerType 是一个协议  而UIbindObser遵守了这个协议
        textFlied.rx.text.bind(to: label.rx.text).addDisposableTo(bag)
        
    }
    
    
    
    @objc fileprivate func textFiledDemo(){
        
        // 2 监听UITextfiled的文字改变
        //         let textF = UITextField()
        // 2.1 第一种方式
        
        textFlied.rx.text.subscribe { (event : Event<String?>) in
            // element 取出这个元素  取出来的是可选类型中的可选类型 可以解包两次
            print(event.element!!)
            }.addDisposableTo(bag)
        
        
        // 2.1 第二种方式 onNext
        textFlied.rx.text.subscribe(onNext: { (str : String?) in
            print(str!)
        }).addDisposableTo(bag)

        
    }
    
    
    
    @objc fileprivate func btnDemo(){
        
        // 1 监听按钮点击
        // 要用局部的按钮 方便提示
        // let button = UIButton();
        btn1.rx.tap.subscribe { (event : Event<()>) in
            print("我是按钮我被点击了")
            }.addDisposableTo(bag)
    
    }
    


}






