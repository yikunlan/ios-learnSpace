//
//  AngreBirdVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/22.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class AngryBirdVC: UIViewController {
    private lazy var bird : UIView = {
        let v = UIView.init(frame: .init(x: 100, y: UIScreen.main.bounds.height - 300, width: 30, height: 30))
        v.backgroundColor = .green
        return v
    }()
    
    private lazy var pig : UIView = {
        let v = UIView.init(frame: .init(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 200, width: 30, height: 30))
        v.backgroundColor = .red
        return v
    }()
    
    private lazy var dynamicAnimator : UIDynamicAnimator = {
        let a = UIDynamicAnimator.init(referenceView: self.view)
        return a
    }()
    
    private lazy var gravity : UIGravityBehavior = {
        let g = UIGravityBehavior.init(items: [bird])
        return g
    }()
    
    private lazy var collision : UICollisionBehavior = {
        let c = UICollisionBehavior.init(items: [bird,pig])
        c.translatesReferenceBoundsIntoBoundary = true
        c.collisionDelegate  = self
        return c
    }()
    
    private lazy var path : UIBezierPath = {
        let p = UIBezierPath.init(arcCenter: bird.center, radius: 80, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        return p
    }()
  
    override func loadView() {
        self.view = AngryBGView.init(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(bird)
        view.addSubview(pig)
        addGesture()
        dynamicAnimator.addBehavior(collision)
        
        (view as! AngryBGView).path = path
        view.setNeedsDisplay()
    }
    
    
    private func addGesture() {
        let pan : UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panSelector(_:)))
        bird.addGestureRecognizer(pan)
    }
    
    
    
    @objc
    func panSelector(_ sender : UIPanGestureRecognizer) {
        let offset = sender.translation(in: sender.view)
        let currentPoint = sender.location(in: self.view)
        //以刚开始在点为圆心画一个半径80的圆，超出这个圆就不移动小鸟了
        if path.contains(currentPoint) {
            sender.setTranslation(.zero, in: sender.view)
            bird.transform = bird.transform.translatedBy(x: offset.x, y: offset.y)
            
            if sender.state == .ended  {
                let offsetX = sender.view!.center.x - currentPoint.x
                let offsetY = sender.view!.center.y - currentPoint.y
                let distance = sqrt(offsetX * offsetX + offsetY * offsetY)
                
                dynamicAnimator.addBehavior(gravity)
                //设置推力
                let push = UIPushBehavior.init(items: [bird], mode: UIPushBehavior.Mode.instantaneous)
                //设置速度
                let magnitude = resultWithConsult(consule: distance, resultValue: .init(startValue: 0, endValue: 1), consultValue: .init(startValue: 0, endValue: 80))
                push.magnitude =  magnitude
                print("速度：",magnitude)
                //设置方向
                push.pushDirection = .init(dx: offsetX/50, dy: offsetY/50)
                dynamicAnimator.addBehavior(push)
            }
            
        }
    }
}



//MARK:- collisionDelegate
extension AngryBirdVC : UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print("两个物体碰撞了")
        gravity.addItem(pig)
    }
}

//MARK:- 计算的速度大小的方法
/**
 *  根据参考获取结果
 *
 *  @param consule      参考值
 *  @param resultValue  结果的start到end
 *  @param consultValue 参考的start到end
 *
 *  @return 结果指
 */
extension AngryBirdVC {
    func resultWithConsult(consule : CGFloat, resultValue : YHValue,consultValue : YHValue) -> CGFloat {
        // 0 - 100

        // 0 - 1

        // a * r.start + b = c.start
        // a * r.end + b = c.end

        // a * (r.start - r.end) + b = c.start - c.ent;
        
        let a : CGFloat = (resultValue.startValue - resultValue.endValue)/(consultValue.startValue - consultValue.endValue)
        let b = resultValue.startValue - (a * consultValue.startValue)
        return a * consule + b
    }
}

class YHValue {
    var startValue:CGFloat
    var endValue:CGFloat
    init(startValue:CGFloat,endValue:CGFloat) {
        self.startValue = startValue
        self.endValue = endValue
    }
}
