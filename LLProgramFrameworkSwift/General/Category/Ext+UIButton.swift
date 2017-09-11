//
//  Ext+UIButton.swift
//  SwiftPractice
//
//  Created by liushaohua on 15/10/22.
//  Copyright © 2015年 liushaohua. All rights reserved.
//

import UIKit

extension UIButton{


    // 遍历构造函数
    /// 创建button
    ///
    /// - parameter setImage:           默认状态图片
    /// - parameter setBackgroundImage: 背景图片
    /// - parameter target:             target
    /// - parameter action:             action
    ///
    /// - returns:
    convenience init(setImage:String,setBackgroundImage:String,target:Any?,action:Selector ){
//        let Btn = UIButton()
        self.init()
        
        self.setImage(UIImage(named:setImage), for: UIControlState.normal)
        self.setImage(UIImage(named:"\(setImage)_highlighted"), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage(named:setBackgroundImage), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named:"\(setBackgroundImage)_highlighted"), for: UIControlState.highlighted)
        
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
    }
    
    
    
    /// 返回带文字的图片的按钮
    ///
    /// - parameter setHighlightImage: 背景图片
    /// - parameter title:             文字
    /// - parameter target:            target
    /// - parameter action:            action
    ///
    /// - returns: 
    convenience init(setHighlightImage:String?,title:String?,target:Any?,action:Selector ){
        //        let Btn = UIButton()
        self.init()

        if let img = setHighlightImage {
            self.setImage(UIImage(named:img), for: UIControlState.normal)

            self.setImage(UIImage(named:"\(img)_highlighted"), for: UIControlState.highlighted)
        }
        
        if let tit = title {
            self.setTitle(tit, for: UIControlState.normal)
            self.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            self.setTitleColor(LLTHEMECOLOR, for: UIControlState.highlighted)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
        
    }

    convenience init(BackgroundImage:String?,title:String?,titleColor:UIColor, target:Any?,action:Selector ){
        
        self.init()

        self.setBackgroundImage(UIImage(named:BackgroundImage!), for: UIControlState.normal)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.sizeToFit()
        
    }
    

}
