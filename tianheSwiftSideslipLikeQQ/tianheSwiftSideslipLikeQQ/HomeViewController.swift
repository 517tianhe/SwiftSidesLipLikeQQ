//
//  HomeViewController.swift
//  tianheSwiftSideslipLikeQQ
//
//  Created by wanglj on 15/7/15.
//  Copyright (c) 2015年 iosdevelop. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var titleOfOtherPages = ""
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        // 设置中间 segmentView 视图
        let segmentView = UISegmentedControl(items: ["消息", "电话"])
        segmentView.selectedSegmentIndex = 0
        segmentView.setWidth(60, forSegmentAtIndex: 0)
        segmentView.setWidth(60, forSegmentAtIndex: 1)
        self.navigationItem.titleView = segmentView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOtherPages" {
            if let a = segue.destinationViewController as? OtherPageViewController {
                a.PageTitle = titleOfOtherPages
            }
        }
    }
}
