//
//  LLProgressHUD.swift
//  LLProgramFrameworkSwift
//
//  Created by 奥卡姆 on 2017/9/10.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit
import SVProgressHUD

enum HUDType {
    case success
    case error
    case loading
    case info
    case progress
}

class LLProgressHUD: NSObject {
    
    
    class func initLLProgressHUD() {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
        
    class func showSuccess(_ status: String) {
        self.showLLProgressHUD(type: .success, status: status)
    }
    class func showError(_ status: String) {
        self.showLLProgressHUD(type: .error, status: status)
    }
    class func showLoading(_ status: String) {
        self.showLLProgressHUD(type: .loading, status: status)
    }
    class func showInfo(_ status: String) {
        self.showLLProgressHUD(type: .info, status: status)
    }
    class func showProgress(_ status: String, _ progress: CGFloat) {
        self.showLLProgressHUD(type: .success, status: status, progress: progress)
    }
    class func dismissHUD(_ delay: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
}


extension LLProgressHUD {
    class func showLLProgressHUD(type: HUDType, status: String, progress: CGFloat = 0) {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
        case .error:
            SVProgressHUD.showError(withStatus: status)
        case .loading:
            SVProgressHUD.show(withStatus: status)
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
        case .progress:
            SVProgressHUD.showProgress(Float(progress), status: status)
        }
    }
}

