//
//  ViewController.swift
//  tianheSwiftSideslipLikeQQ
//
//  Created by wanglj on 15/7/15.
//  Copyright (c) 2015年 iosdevelop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mainTabBarController: MainTabBarController!
    var tapGesture: UITapGestureRecognizer!
    
    var homeNavigarionController: UINavigationController!
    var homeViewController: HomeViewController!
    var leftviewController: LeftViewController!
    var mainView: UIView! //构造主视图.实现 UINavigationController.view 和 HomeViewController.view 一起缩放。
    var distance: CGFloat = 0
    
    let FullDistance: CGFloat = 0.78
    let Proportion: CGFloat = 0.77
    
    var blackCover: UIView!
    
    var centerOfLeftviewAtBeginning: CGPoint!
    var proportionOfLeftView: CGFloat = 1
    var distanceOfLeftView: CGFloat = 50
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 给主视图添加背景图片
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(imageView)
        
        //通过storyBoard 取出LeftViewController
        
        leftviewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("THLeftViewController") as! LeftViewController
        if Commn.screeWidth > 320
        {
            proportionOfLeftView = Commn.screeWidth / 320
            distanceOfLeftView += (Commn.screeWidth - 320) * FullDistance / 2

        }
        leftviewController.view.center = CGPointMake(leftviewController.view.center.x - 50, leftviewController.view.center.y)
        leftviewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8)
        
        centerOfLeftviewAtBeginning = leftviewController.view.center
        
        self.view.addSubview(leftviewController.view)
        
        //增加黑色遮罩层,实现视差特效
        blackCover = UIView(frame: CGRectOffset(self.view.frame, 0, 0))
        blackCover.backgroundColor = UIColor.blackColor()
        self.view.addSubview(blackCover)
        
        
        //通过storyBoard 取出HomeViewController 的 view, 放在背景视图上面
        mainView = UIView(frame: self.view.frame)
        
        let nibContents = NSBundle.mainBundle().loadNibNamed("MainTabBarController", owner: nil, options: nil)
        mainTabBarController = nibContents.first as! MainTabBarController
        
        let tabBarView = mainTabBarController.view
        mainView.addSubview(tabBarView)
        
        homeNavigarionController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeNavigationController") as! UINavigationController
        
        homeViewController = homeNavigarionController.viewControllers.first as! HomeViewController
        tabBarView.addSubview(homeViewController.navigationController!.view)
        tabBarView.addSubview(homeViewController.view)
        
        tabBarView.bringSubviewToFront(mainTabBarController.tabBar)
        
        self.view.addSubview(mainView)
        
        homeViewController.navigationItem.leftBarButtonItem?.action = Selector("showLeft")
        homeViewController.navigationItem.rightBarButtonItem?.action = Selector("showRight")
        //绑定 UIpanGestureRecongnizer
        let panGesture = homeViewController.panGesture
        panGesture.addTarget(self, action: Selector("pan:"))
        mainView.addGestureRecognizer(panGesture)
        
        
        println("\(Commn.screeWidth)")
        println("\(Commn.screeHeight)")
        println("\(self.view.center.x)")
        
        // 生成单击收起菜单手势
        tapGesture = UITapGestureRecognizer(target: self, action: "showHome")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //响应 UIPanGestureRecognizer 事件
    func pan(recongnizer: UIPanGestureRecognizer)
    {
        let x = recongnizer.translationInView(self.view).x
        let trueDistance = distance + x // 实时距离
        let trueProportion = trueDistance / (Commn.screeWidth * FullDistance)
        
        //如果 UIPanGesttureRecognizer 结束,则激活自动停靠
        if recongnizer.state == UIGestureRecognizerState.Ended{
            
            if trueDistance > Commn.screeWidth * (Proportion/3){
                showLeft()
            }else if trueDistance < Commn.screeWidth * -(Proportion / 3){
                showRight()
            }else{
                showHome()
            }
            return
        }
        
        //计算缩放比例 通过缩放比例的公式
        var proportion: CGFloat = recongnizer.view!.frame.origin.x >= 0 ? -1 : 1
        proportion *= trueDistance / Commn.screeWidth
        proportion *= 1 - Proportion
        proportion /= 0.6
        proportion += 1
        if proportion <= Proportion{ //若缩放比例已经达到最小,则不再继续动画
            return
        }
        //执行视差特效
        blackCover.alpha = (proportion - Proportion) / (1 - Proportion)
    
        //执行平移和缩放动画
        println("center = \(recongnizer.view!.center)")
        recongnizer.view!.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y)
        recongnizer.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
        
        // 执行左视图动画
        let pro = 0.8 + (proportionOfLeftView - 0.8) * trueProportion
        leftviewController.view.center = CGPointMake(centerOfLeftviewAtBeginning.x + distanceOfLeftView * trueProportion, centerOfLeftviewAtBeginning.y  )
        leftviewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro)
    }
    
    //封装三个方法 ,便于后期调用
    
    //展示左视图
    func showLeft(){
        mainView.addGestureRecognizer(tapGesture)
        distance = self.view.center.x * (FullDistance*2 + Proportion - 1)
        doTheAnimate(self.Proportion, showWhat: "left")
        homeNavigarionController.popToRootViewControllerAnimated(true)
        
    }
    //展示主视图
    func showHome()
    {
        mainView.removeGestureRecognizer(tapGesture)
        distance = 0
        doTheAnimate(1, showWhat: "home")
    }
    
    //展示右视图
    func showRight()
    {
        mainView.addGestureRecognizer(tapGesture)
        distance = self.view.center.x * -(FullDistance*2 + Proportion - 1)
        doTheAnimate(self.Proportion, showWhat: "right")
    }
    
    // 执行三种试图展示
    func doTheAnimate(proportion: CGFloat, showWhat: String) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.mainView.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y)
            self.mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
            if showWhat == "left" {
                self.leftviewController.view.center = CGPointMake(self.centerOfLeftviewAtBeginning.x + self.distanceOfLeftView, self.leftviewController.view.center.y)
                self.leftviewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.proportionOfLeftView, self.proportionOfLeftView)
            }
            self.blackCover.alpha = showWhat == "home" ? 1 : 0
            self.leftviewController.view.alpha = showWhat == "right" ? 0 : 1
            }, completion: nil)
    }


}

