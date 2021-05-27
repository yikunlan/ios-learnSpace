//
//  AnimationLearnVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/16.
//  Copyright © 2020  huangyikun. All rights reserved.
// 核心动画的学习
// 核心动画只是针对layer而言，不能直接对view

import UIKit

class AnimationLearnVC: UIViewController {
    
    lazy var circleView : CirclePathView = {
        let c = CirclePathView.init(frame:.init(x: 100, y: 100, width: 200, height: 200))
        c.backgroundColor = UIColor.clear
        return c
    }()
    lazy var redView : UIView = {
        let v = UIView.init(frame: .init(x: 100, y: 100, width: 100, height: 100))
        v.backgroundColor = UIColor.red
        return v
    }()

    lazy var redLayer : CALayer = {
        return redView.layer
    }()
    
    lazy var yellowView : UIView = {
        let v = UIView.init(frame: .init(x: 100, y: 100, width: 30, height: 30))
        v.backgroundColor = UIColor.yellow
        return v
    }()
    
    lazy var yellowLayer : CALayer = {
        return yellowView.layer
    }()
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "1"))
        iv.isUserInteractionEnabled = true
        iv.center = view.center
        view.addSubview(iv)
        return iv
    }()
    var imageName = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "核心动画学习"
        self.view.backgroundColor = UIColor.white
        
        addGesture2IV()
        self.view.addSubview(circleView)
        self.view.addSubview(redView)
        self.view.addSubview(yellowView)
        
        
    }
     
    /***
     给imageview添加手势
     */
    private func addGesture2IV(){
        let gesture = UISwipeGestureRecognizer.init(target: self, action: #selector(gestureSelector(_:)))
        gesture.direction = UISwipeGestureRecognizer.Direction.left
        let gesture1 = UISwipeGestureRecognizer.init(target: self, action: #selector(gestureSelector(_:)))
        imageView.addGestureRecognizer(gesture)
        imageView.addGestureRecognizer(gesture1)
    }
    //MARK:- 转场动画
    @objc
    func gestureSelector(_ sender: UISwipeGestureRecognizer){
        //1、创建动画
        let transition = CATransition.init()
        //2、怎么做动画
        transition.type = CATransitionType.fade
        if sender.direction == UISwipeGestureRecognizer.Direction.left {
            transition.subtype = CATransitionSubtype.fromRight
        } else if(sender.direction == UISwipeGestureRecognizer.Direction.right){
            
            transition.subtype = CATransitionSubtype.fromLeft
        }
        imageName += 1
        if imageName > 5 {
            imageName = 1
        }
        self.imageView.image = UIImage.init(named: String(imageName))
        //3、添加动画
        self.imageView.layer.add(transition, forKey: nil)
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        baseAnimation()
        keyFrameAnimation()
    }
    
    
    //MARK:- 关键帧动画
    private func keyFrameAnimation(){
        
        //1、创建动画
        let keyFrameAnim = CAKeyframeAnimation.init()
        
        //2、怎么做动画
        keyFrameAnim.keyPath = "position"
        
        //第一种动画方式，通过keyPath来设置
//        let value1 = NSValue.init(cgPoint: .init(x: 100, y: 100))
//        let value2 = NSValue.init(cgPoint: .init(x: 200, y: 100))
//        let value3 = NSValue.init(cgPoint: .init(x: 200, y: 200))
//        let value4 = NSValue.init(cgPoint: .init(x: 100, y: 200))
//        keyFrameAnim.values = [value1,value2,value3,value4]
        
        //第二种方式，通过path来设置
        let path = UIBezierPath.init(arcCenter: .init(x: 200, y: 200), radius: 100, startAngle: 0, endAngle: .pi*2, clockwise: true)
        keyFrameAnim.path = path.cgPath
        
        keyFrameAnim.duration = 3
        keyFrameAnim.repeatCount = Float(INT_MAX)
        //3、对谁做动画
        self.yellowLayer.add(keyFrameAnim, forKey: nil)
        
        //todo 为啥不动呢？？？
    }
    
    //MARK:- 基本动画
    private func baseAnimation(){
        //1、创建动画对象（做什么动画）
        let anim = CABasicAnimation.init()
        //2、怎么做动画
        anim.keyPath = "position.x"
        //从哪里到哪里
//        anim.fromValue = (10)
//        anim.toValue = (300)
        //从当前位置添加多少
        anim.byValue = (10)
        
        //不希望回到原来的位置
        anim.fillMode = CAMediaTimingFillMode.forwards
        anim.isRemovedOnCompletion = false
        
        //3、添加动画
        redLayer.add(anim, forKey: nil)
    }
}
