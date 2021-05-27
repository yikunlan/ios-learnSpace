//
//  AnimationVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/9/3.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import Foundation
import UIKit

class AnimationVC: UIViewController {
    
    lazy var viewA : UIView = {
        let v = UIView.init(frame: .init(x: 50, y: 50, width: 100, height: 100))
        v.backgroundColor = .black
        return v
    }()
    
    
    lazy var viewB : UIView = {
        let v = UIView.init(frame: .init(x: 50, y: 150, width: 100, height: 100))
        v.backgroundColor = .yellow
        return v
    }()
    
    lazy var btn : UIButton = {
        let btn = UIButton.init(frame: .init(x: 50, y: 50, width: 20, height: 20))
        btn.center = self.view.center
        btn.backgroundColor = .red
        btn.setTitle("点击开始动画", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(startAnim), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var pushTransition : CATransition = {
        let push = CATransition()
        push.type = .push
        push.subtype = .fromRight
        push.duration = 3
        push.fillMode = .forwards
        push.timingFunction = .init(name: .easeIn)
        push.isRemovedOnCompletion = true
        push.startProgress = 0.8
        return push
    }()
    
    lazy var fadeTransition : CATransition = {
        let fade = CATransition()
        fade.type = .moveIn
        fade.subtype = .fromRight
        fade.duration = 3
        fade.fillMode = .forwards
        fade.timingFunction = .init(name: .easeInEaseOut)
        fade.isRemovedOnCompletion = true
//        fade.startProgress = 0.8
        return fade
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        view.addSubview(viewB)
        view.addSubview(viewA)
        view.addSubview(btn)
    }
    @objc
    private func startAnim() {
        viewA.layer.add(self.fadeTransition, forKey: "fade")
        viewB.layer.add(self.pushTransition, forKey: "push")
    }


}
