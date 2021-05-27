//
//  CollisionVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/20.
//  Copyright © 2020  huangyikun. All rights reserved.
//  重力、碰撞、附着等的物理引擎的demo

import UIKit

class CollisionVC: UIViewController {
    
    let kCollisionPathKey = "key"
    
    lazy var maomaoBtn : UIButton = {
        let b = UIButton.init(frame: .init(x: 200, y: 100, width: 100 , height: 100))
        b.setTitle("毛毛虫", for: UIControl.State.normal)
        b.backgroundColor = UIColor.blue
        b.setTitleColor(UIColor.black, for: UIControl.State.normal)
        b.addTarget(self, action: #selector(presentMMVC(_:)), for: UIControl.Event.touchUpInside)
        return b
        
    }()
    lazy var birdBtn : UIButton = {
        let b = UIButton.init(frame: .init(x: 200, y: 200, width: 100 , height: 80))
        b.setTitle("愤怒小鸟", for: UIControl.State.normal)
        b.backgroundColor = UIColor.yellow
        b.setTitleColor(UIColor.black, for: UIControl.State.normal)
        b.addTarget(self, action: #selector(presentBirdVC(_:)), for: UIControl.Event.touchUpInside)
        return b
        
    }()
    
    @objc
    func presentMMVC(_ sender : UIButton) {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"]as! String
        let vc = NSClassFromString(namespace + "." + "MaomaochongVC") as! UIViewController.Type
        navigationController?.pushViewController(vc.init(), animated: true)
    }
    @objc
    func presentBirdVC(_ sender : UIButton) {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"]as! String
        let vc = NSClassFromString(namespace + "." + "AngryBirdVC") as! UIViewController.Type
        navigationController?.pushViewController(vc.init(), animated: true)
    }
    
    lazy var redView :UIView = {
        let v = UIView.init(frame: .init(x: 20, y: 80, width: 100, height: 100))
        v.backgroundColor = UIColor.red
        return v
        
    }()
    lazy var yellowView :UIView = {
        let v = UIView.init(frame: .init(x: 200, y: view.bounds.height - 50, width: 50, height: 50))
        v.backgroundColor = UIColor.yellow
        return v
        
    }()
    
//    lazy var contentView : UIView = {
//        let v = UIView.init(frame: .init(x: 200, y: 80, width: 400, height: 400))
//        v.backgroundColor = UIColor.blue
//        return v
//    }()
    
    override func loadView() {
        self.view = collisionPathView.init(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(maomaoBtn)
        view.addSubview(birdBtn)
        view.addSubview(redView)
//        view.addSubview(contentView)
//        contentView.addSubview(redView)
        view.addSubview(yellowView)
    }
    
    //重力
    lazy var gravity : UIGravityBehavior = {
        let g = UIGravityBehavior.init(items: [redView,yellowView])
        //设置重力加速度的数值
        g.magnitude = 5
        return g
    }()
    
    //碰撞
    lazy var collision : UICollisionBehavior = {
        let c = UICollisionBehavior.init(items: [redView,yellowView])
        //把view作为边界
        c.translatesReferenceBoundsIntoBoundary = true
        //碰撞的模式
//        c.collisionMode = .boundaries//只跟边界发生碰撞
//        c.collisionMode = .everything//跟边界和item发生碰撞
//        c.collisionMode = .items//只跟设置的items发生碰撞
        
        //自定义边界
        c.addBoundary(withIdentifier: kCollisionPathKey as NSCopying, from: .init(x: 0, y: 200), to: .init(x: 200, y: 300))
        
        //action 添加监听事件
        c.action = {
            //监听物体的y的值
            if(self.redView.frame.minY > 400){
                self.redView.backgroundColor = UIColor.yellow
            }
        }
        
        //添加代理
        c.collisionDelegate = self
        
        return c
    }()
    
    //甩
    lazy var snap : UISnapBehavior = {
        let s = UISnapBehavior.init(item: self.redView, snapTo: .init(x: 100, y: 600))
        s.damping = 1//速度，数值越大速度越慢晃的越小，数值越小速度越快晃的幅度越大
        return s
    }()
    
    //附着
    var attach : UIAttachmentBehavior?
    
    //动力学元素，自身属性
    lazy var itemBehavior : UIDynamicItemBehavior = {
        let item = UIDynamicItemBehavior.init(items: [self.redView])
        item.elasticity = 0.8//弹力
//        item.density = 0.5 //密度
        item.friction = 1 //摩擦力
        return item
    }()
    
    lazy var animator : UIDynamicAnimator = {
        //1、根据某一个范围，创建动画者对象
        let a = UIDynamicAnimator.init(referenceView: self.view)
        return a
    }()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let t = touches.first {
            let p = t.location(in: t.view)
            //2、根据某一个动力学元素，创建行为
            /***就是创建gravity、collision这些行为***/
//            attach = .init(item: self.redView, attachedToAnchor: p)
            //固定附着的距离
//            attach?.length = 100
            //设置成弹性附着
//            attach?.damping = 0.5
//            attach?.frequency = 1
            //3、把行为添加到动画者当中
//            animator.addBehavior(attach!)
            
            animator.addBehavior(gravity)
            animator.addBehavior(collision)
            animator.addBehavior(itemBehavior)
            
    //        animator.addBehavior(snap)
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            let p = t.location(in: t.view)
            
            attach?.anchorPoint = p
        }
    }
    
}

extension CollisionVC : UICollisionBehaviorDelegate {
    //碰撞到边界的监听
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        //identifier == nil 的时候是碰撞到边界了
        if (identifier != nil) {
            let id : String = identifier as! String
            if id == kCollisionPathKey {
                self.redView.backgroundColor = UIColor.blue
            }
        }
    }
}
