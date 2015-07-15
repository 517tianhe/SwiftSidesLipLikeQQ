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
        homeViewController = UIStoryboard(name: "main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        self.view.addSubview(homeViewController.view)
        
        //绑定 UIpanGestureRecongnizer
        homeViewController.panGesture.addTarget(self, action: Selector("pan"))
        
        
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
        
        
        
    }
    
    //封装三个方法 ,便于后期调用
    
    //展示左视图
    func showLeft(){
        
    }
    //展示主视图
    func showHome()
    {
        
    }
    
    //展示右视图
    func showRight()
    {
        
    }
    
    //执行三种视图展示
    func doTheAnimate(proportion: CGFloat)
    {
        
    }


}

