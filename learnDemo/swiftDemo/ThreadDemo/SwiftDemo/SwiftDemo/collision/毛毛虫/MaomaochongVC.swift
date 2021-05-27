//
//  MaomaochongVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/21.
//  Copyright © 2020  huangyikun. All rights reserved.
//  使用动态动画实现毛毛虫效果

import UIKit

class MaomaochongVC: UIViewController {
    
    var attach : UIAttachmentBehavior?
    
    lazy var bodys : Array <UIView> = {
        var array = Array<UIView>()
        for i in 0 ... 9 {
            var w = 20
            var h = 20
            var x = (i+1) * w
            var y = 80
            
            let v = UIView.init(frame: .init(x: x, y: y, width: w, height: h))
            
            v.backgroundColor = UIColor.red
            if i == 9 {
                w = 40
                h = 40
                y = y + w * Int(0.5)
                v.backgroundColor = UIColor.yellow
                v.frame = .init(x: x, y: y, width: w, height: h)
            }
            v.clipsToBounds = true
            v.layer.cornerRadius = CGFloat(w) * 0.5
            
            array.append(v)
        }
        
        return array
    }()
    
    lazy var animator : UIDynamicAnimator = {
        let a = UIDynamicAnimator.init(referenceView: self.view)
        return a
    }()
    
    lazy var gravity : UIGravityBehavior = {
        let g = UIGravityBehavior.init(items: bodys)
        return g
    }()
    
    lazy var collision : UICollisionBehavior = {
        let c = UICollisionBehavior.init(items: bodys)
        c.translatesReferenceBoundsIntoBoundary = true
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        bodys.forEach { (v) in
            self.view.addSubview(v)
        }
        for i in 0 ... bodys.count - 2 {
            let a = UIAttachmentBehavior.init(item: bodys[i], attachedTo: bodys[i + 1])
            animator.addBehavior(a)
        }
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            let p = t.location(in: self.view)
            
            if attach == nil {
                attach = UIAttachmentBehavior.init(item: bodys.last!, attachedToAnchor: p)
            }
            attach?.anchorPoint = p
            animator.addBehavior(attach!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            let p = t.location(in: self.view)
            
            if attach != nil {
                attach?.anchorPoint = p
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animator.removeBehavior(attach!)
    }
}
