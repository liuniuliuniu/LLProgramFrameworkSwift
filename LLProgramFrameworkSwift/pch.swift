//
//  pch.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/5.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit

// 判断系统
let IOS7 = Int(UIDevice.current.systemVersion)! >= 7 ? true : false;
let IOS8 = Int(UIDevice.current.systemVersion)! >= 8 ? true : false;
let IOS9 = Int(UIDevice.current.systemVersion)! >= 9 ? true : false;
let IOS11 = Int(UIDevice.current.systemVersion)! >= 11 ? true : false;

// 判断设备
func isX() -> Bool {
    if UIScreen.main.bounds.height == 812 {
        return true
    }
    return false
}


let LLSCREENW = UIScreen.main.bounds.width
let LLSCREENH = UIScreen.main.bounds.height
//MARK:NAV高度
let NAVMargin = isX() ? 88 : 64
//MARK:TABBAR高度
let TABBARMargin = isX() ? 83 : 49

let LLTHEMECOLOR = UIColor.yellow


func LLRandomColor() -> UIColor{
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}

func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

let LLBigFontSize: CGFloat = 18
let LLNomalFontSize:CGFloat = 14
let LLSmallFontSize:CGFloat = 10

// 自定义打印方法
func printLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(message)")
        
    #endif
}






