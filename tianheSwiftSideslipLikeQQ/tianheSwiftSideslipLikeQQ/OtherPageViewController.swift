//
//  OtherPageViewController.swift
//  tianheSwiftSideslipLikeQQ
//
//  Created by wanglj on 15/7/16.
//  Copyright (c) 2015年 iosdevelop. All rights reserved.
//

import UIKit

class OtherPageViewController: UIViewController {
    
    var PageTitle: String!  //从 HomeviewContorller 传递过来的值
    
    @IBOutlet weak var mainLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = PageTitle
        
        //自定义返回按钮
        
        let backButton = UIBarButtonItem(title: "<返回", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
        self.navigationItem.leftBarButtonItem = backButton
        
        //弥补因为返回按钮被替换导致的边缘划入手势失效的问题
        
        let gesture = UIPanGestureRecognizer(target: self, action: "goBack")
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
        Commn.rootViewController.mainTabBarController.tabBar.hidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
