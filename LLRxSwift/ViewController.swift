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

// RxSwift的思想  让任何一个变量都是可以监听的
struct Student {
    var score : Variable<Double>
    
}


class ViewController: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var textFlied: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var scrollV: UIScrollView!
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
//        subjectPracticeDemo()
        
//        mapDemo()
        
//        disposeDemo()
        
    }
    
    @IBAction func RxSwiftUITableView(_ sender: Any) {
        
       self.navigationController?.pushViewController(RxSwiftUITableViewVC(), animated: true)
        
    }
}



extension ViewController{
    
    
        
    
    func disposeDemo() {
        
        // 1  dispose() 让对象立即销毁掉 后边在改变值的时候 此对象已经销毁了
        let variable1 = Variable("奥卡姆剃须刀")
        variable1.asObservable().subscribe { (event : Event<String>) in
            print(event)
        }.dispose()
        
        
        // 2 DisposeBag
        let subject = BehaviorSubject(value: "a")
        subject.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        
        
        
        
        
    }
    
    
    
    
    func mapDemo() {
        
        
        //  1 swift中map的使用
        let array = [1,2,3,4]
        
        let arr2 = array.map { (num : Int) -> Int in
            return num * num
        }
        
        print(arr2)
//         swift的函数式编程  用的还是比较少的 还是习惯于面向对象的方式
        let arr3 = array.map({ $0 * $0 })
        
        print(arr3)
        
        //  2 rxswift 中map函数的使用
        Observable.of(10,11,12,13)
            .map { (num : Int) -> Int in
                return num * num
            }.subscribe { (event : Event<Int>) in
                print(event)
            }.addDisposableTo(bag)
        
        
        
        // 3 flatmap 的使用  映射 Observable的
        let stu1 = Student(score: Variable(100))
        let stu2 = Student(score: Variable(99))
        let stu3 = Student(score: Variable(98))
        
        
        //   链式编程思维
        let studentVariable = Variable(stu1)
        //  这个方法会把所有的是都监听到 都打印 但常常我们只关心最新的一个订阅
//        studentVariable.asObservable().flatMap { (stu : Student) -> Observable<Double> in
//            return stu.score.asObservable()
//            }.subscribe { (event : Event<Double>) in
//            print(event)
//        }.addDisposableTo(bag)
        
        // 常用的是这一个方法  会先打印一下初始化的数据  只会关心最新订阅值的改变
        studentVariable.asObservable().flatMapLatest { (stu : Student) -> Observable<Double> in
            return stu.score.asObservable()
            }.subscribe { (event : Event<Double>) in
                print(event)
            }.addDisposableTo(bag)
        
        studentVariable.value = stu2
        stu2.score.value = 0
        // 这样的话每一个值的改变都会发送信号
        
        //  我已经不关心你的 不订阅你了
        stu1.score.value = 1000;
        
        
        
    }
    
    
    
    
    
    
    
    
    func subjectPracticeDemo() {
        
        
        // 1 publishSubject 订阅者只能接受，订阅之后的事件 也就是必须先订阅 再发送事件
        let publishSub = PublishSubject<String>()
        
        publishSub.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        publishSub.onNext("奥卡姆剃须刀")
        
        
        // 2 ReplySubject 当你订阅ReplySubject 的时候，你可以接收到订阅他之后的事件，但也可以接收订阅他之前发出的事件 ，接收几个事件取决于bufferSize的大小  会接收最后发送的信号
        
//        let replySub  = ReplaySubject<String>.create(bufferSize: 2)
        // 没有限制的replySubject
        let replySub = ReplaySubject<String>.createUnbounded()
        
        replySub.onNext("1")
        replySub.onNext("2")
        replySub.onNext("3")
        replySub.onNext("4")
        
        replySub.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        replySub.onNext("5")
        
        // 3 BehaviorSubject  当你订阅了BehaviorSubject  你就会接收到订阅之前的最后一个事件  可以初始化的时候就给一个订阅值
        // 这个用的是最多的  一般用法是初始的时候给一个默认数据 然后进行刷新加载更多数据
        let behaviorSub = BehaviorSubject(value: "10")
        
        behaviorSub.onNext("a")
        // 只能订阅到 b
        behaviorSub.onNext("b")
        
        behaviorSub.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        behaviorSub.onNext("11")
        behaviorSub.onNext("12")
        behaviorSub.onNext("13")
        
        
        // 4 Variable 
        // Variable 是BehaviorSubject 一个包装箱 就像是一个箱子一样 使用的时候需要调用asObservable() 拆箱，里面的Value 是一个BehaviorSubject  
        //  如果 Variable 打算发出事件  直接修改对象的Value即可
        
        // 当事件结束的时候 Variable  会自动发出complete事件
        
        let variable = Variable("a")
        
        // 要是想修改值 直接修改value就好
        variable.value = "b"
        
        variable.asObservable().subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        // 也能发出事件
        variable.value = "c"
        variable.value = "d"
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func practiceDemo() {
        
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






