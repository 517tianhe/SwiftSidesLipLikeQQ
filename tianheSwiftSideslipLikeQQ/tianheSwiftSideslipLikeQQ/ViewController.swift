//
//  ViewController.swift
//  tianheSwiftSideslipLikeQQ
//
//  Created by wanglj on 15/7/15.
//  Copyright (c) 2015年 iosdevelop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var homeViewController: HomeViewController!
    var distance: CGFloat = 0
    
    let FullDistance: CGFloat = 0.78
    let Proportion: CGFloat = 0.77
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 给主视图添加背景图片
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(imageView)
        
        //通过storyBoard 取出HomeViewController 的 view, 放在背景视图上面
        homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("THHomeViewController") as! HomeViewController
        self.view.addSubview(homeViewController.view)
        
        //绑定 UIpanGestureRecongnizer
        let panGesture = homeViewController.panGesture
        panGesture.addTarget(self, action: Selector("pan:"))
        println("\(Commn.screeWidth)")
        println("\(Commn.screeHeight)")
        println("\(self.view.center.x)")
        
        
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
        //执行平移和缩放动画
        println("center = \(recongnizer.view!.center)")
        recongnizer.view!.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y)
        recongnizer.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
    }
    
    //封装三个方法 ,便于后期调用
    
    //展示左视图
    func showLeft(){
        distance = self.view.center.x * (FullDistance + Proportion / 2)
        println("\(self.view.center.x)")
        doTheAnimate(self.Proportion)
        
    }
    //展示主视图
    func showHome()
    {
        distance = 0
        doTheAnimate(1)
    }
    
    //展示右视图
    func showRight()
    {
        distance = self.view.center.x * -(FullDistance + Proportion / 2)
        doTheAnimate(self.Proportion)
    }
    
    //执行三种视图展示
    func doTheAnimate(proportion: CGFloat)
    {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            self.homeViewController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y)
            self.homeViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion,proportion)
            }, completion: nil
            )
        
    }


}

