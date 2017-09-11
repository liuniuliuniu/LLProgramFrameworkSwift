//
//  LLHelper.swift
//  LLProgramFrameworkSwift
//
//  Created by liushaohua on 2017/9/5.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit


/// 线程加锁
///
/// - Parameters:
///   - lock: 加锁对象
///   - dispose: 执行闭包函数,
func synchronized(_ lock: AnyObject,dispose: ()->()) {
    objc_sync_enter(lock)
    dispose()
    objc_sync_exit(lock)
}

//MARK:            延时使用        ____________________________________________________________________________________________________

typealias TaskBlock = (_ cancel : Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) ->  TaskBlock? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    var closure: (()->Void)? = task
    var result: TaskBlock?
    
    let delayedClosure: TaskBlock = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}
