//
//  Ext+UILable.swift
//  SwiftPractice
//
//  Created by liushaohua on 15/10/23.
//  Copyright © 2015年 liushaohua. All rights reserved.
//

import UIKit


extension UILabel{


    convenience init(text:String,font:CGFloat,textColor:UIColor,maxWidth:CGFloat = 0) {
        self.init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: font)
        self.textColor = textColor
        if maxWidth > 0{
        
            self.preferredMaxLayoutWidth = maxWidth
            self.numberOfLines = 0
        
        }
    }


}

