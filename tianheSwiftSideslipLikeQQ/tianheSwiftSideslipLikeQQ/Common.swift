//
//  Common.swift
//  tianheSwiftSideslipLikeQQ
//
//  Created by wanglj on 15/7/15.
//  Copyright (c) 2015年 iosdevelop. All rights reserved.
//

import UIKit

struct Commn {
    static let screeWidth = UIScreen.mainScreen().applicationFrame.maxX
    static let screeHeight = UIScreen.mainScreen().applicationFrame.maxY
    static let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController
    static let contactsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Contacts") as! UIViewController
}
