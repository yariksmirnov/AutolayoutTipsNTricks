//
//  AppDelegate.swift
//  AutolayoutTipsNTricks
//
//  Created by Yaroslav Smirnov on 30/03/16.
//  Copyright © 2016 Yaroslav Smirnov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
}

extension UINavigationController {
    
    open override var childViewControllerForStatusBarStyle : UIViewController? {
        return topViewController
    }
    
    open override var childViewControllerForStatusBarHidden : UIViewController? {
        return topViewController
    }
    
}

