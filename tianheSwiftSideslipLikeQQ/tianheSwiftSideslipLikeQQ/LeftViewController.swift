//
//  LeftViewController.swift
//  tianheSwiftSideslipLikeQQ
//
//  Created by wanglj on 15/7/15.
//  Copyright (c) 2015年 iosdevelop. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let titlesDictionary = ["开通会员","QQ钱包","网上银行","个性装扮","我的收藏","我的文件"]
    
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var settingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
