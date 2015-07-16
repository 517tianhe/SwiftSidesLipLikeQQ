//
//  LeftViewController.swift
//  tianheSwiftSideslipLikeQQ
//
//  Created by wanglj on 15/7/15.
//  Copyright (c) 2015年 iosdevelop. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let titlesDictionary = ["开通会员", "QQ钱包", "网上营业厅", "个性装扮", "我的收藏", "我的相册", "我的文件"]
    
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var settingTableView: UITableView!

    @IBOutlet weak var heightLayoutConstraintOfSettingTableView: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // settingTableView.tableFooterView = UIView()
        heightLayoutConstraintOfSettingTableView.constant = Commn.screeHeight < 500 ? Commn.screeHeight * (568 - 221) / 568 : 347
        self.view.frame = CGRectMake(0, 0, 320 * 0.78, Commn.screeHeight)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewController =  Commn.rootViewController
        viewController.homeViewController.titleOfOtherPages = titlesDictionary[indexPath.row]
        viewController.homeViewController.performSegueWithIdentifier("showOtherPages", sender: self)
        Commn.contactsVC.view.removeFromSuperview()
        viewController.mainTabBarController.tabBar.hidden = true
        viewController.mainTabBarController.selectedIndex = 0
        viewController.showHome()
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("leftViewcell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.text = titlesDictionary[indexPath.row]
        return cell
    }

}
