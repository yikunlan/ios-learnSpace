//
//  GestureVC.swift
//  SwiftDemo
//  Created by Yk Huang on 2020/10/15.
//  Copyright © 2020  huangyikun. All rights reserved.
//  手势学习

import UIKit

class GestureVC: UIViewController {
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "cat"))
        //要设置可以用户交互，要不然不能响应手势
        iv.isUserInteractionEnabled = true
        view.addSubview(iv)
        iv.center = view.center
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "手势学习"
        view.backgroundColor = UIColor.white
        tabPress()
        longPress()
        swipe()
        rotationGesture()
        pinchGesture()
        panGesture()
    }
    
    //MARK:- 单击

    private func tabPress(){
        //创建手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tabSelector(_:)))
        //点击几次触发这个“单击”事件，改为2的时候说明需要双击才能触发
        tap.numberOfTapsRequired = 2
        //需要同时有几根手机触摸才能触发事件
        tap.numberOfTouchesRequired = 2
        //给需要手势坚挺的控件添加手势监听
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc
    private func tabSelector(_ sender: UITapGestureRecognizer) {
        print("单击了")
    }
    //MARK:- 双击
    private func longPress(){
        //创建手势
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longSelector))
        //设置误差范围，长按的时候，手指可以移动多少距离仍然算是长按，默认10
        longPress.allowableMovement = 20
        //设置多久才算是长按,默认0.5秒
        longPress.minimumPressDuration = 2
        //给需要手势坚挺的控件添加手势监听
        self.imageView.addGestureRecognizer(longPress)
    }
    
    @objc
    private func longSelector(_ sender: UILongPressGestureRecognizer){
        //设置只有第一次长按的时候响应，滑动和最后抬手的时候不响应
        if sender.state == UIGestureRecognizer.State.began {
            print("长按")
        }
    }
    //MARK:- 轻扫 从左往右，从右往左滑动，或者从上往下滑动，从下往上滑动
    private func swipe(){
        //创建手势
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeSelector))
        let swipe2 = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeSelector))
        swipe2.direction = UISwipeGestureRecognizer.Direction.left
        //给需要手势坚挺的控件添加手势监听
        self.imageView.addGestureRecognizer(swipe)
        self.imageView.addGestureRecognizer(swipe2)
    }
    
    @objc
    private func swipeSelector(_ sender: UISwipeGestureRecognizer){
        if sender.direction == UISwipeGestureRecognizer.Direction.left {
            print("从右往左滑")
        } else if sender.direction == UISwipeGestureRecognizer.Direction.right {
            print("从左往右滑")
        }
    }

    
    //MARK:- 旋转手势
    private func rotationGesture(){
        let gesture = UIRotationGestureRecognizer.init(target: self, action: #selector(rotationSelector(_:)))
        //添加代理，避免和缩放和旋转冲突
        gesture.delegate = self
        
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc
    func rotationSelector(_ sender : UIRotationGestureRecognizer) {
        print("旋转了多少角度：",sender.rotation)
        //每次开始都会从0开始旋转，会有一个跳一下的过程
//        imageView.transform = CGAffineTransform.init(rotationAngle: sender.rotation)
        imageView.transform = imageView.transform.rotated(by: sender.rotation)
        /****每次清空，这样子上面的rotated(by:)每次添加的都是这一次和上一次旋转的角度，就会流畅，
         要是不清空的话，每次旋转的角度就是：这次角度+下次角度，一直越来越大，旋转一直越来越快
        **/
        sender.rotation = 0
    }
    
    //MARK:- 捏合🤏手势,也就是缩放
    private func pinchGesture(){
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchSelector(_:)))
        //添加代理，避免和缩放和旋转冲突
        pinch.delegate = self
        self.imageView.addGestureRecognizer(pinch)
    }
    
    @objc
    func pinchSelector(_ sender : UIPinchGestureRecognizer) {
        self.imageView.transform = imageView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    //MARK:- 平移，也就是移动
    private func panGesture(){
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panSelector(_:)))
        self.imageView.addGestureRecognizer(pan)
    }
    
    @objc
    private func panSelector(_ sender:UIPanGestureRecognizer){
        let translatePoint = sender.translation(in: sender.view)
        self.imageView.transform = self.imageView.transform.translatedBy(x: translatePoint.x, y: translatePoint.y)
        sender.setTranslation(.zero, in: sender.view)
    }
}

//MARK:- 分类，手势的代理，解决旋转和缩放的手势冲突问题
extension GestureVC : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
