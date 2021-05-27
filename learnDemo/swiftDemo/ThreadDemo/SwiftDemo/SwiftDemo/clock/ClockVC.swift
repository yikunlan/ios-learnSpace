//
//  ClockVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/15.
//  Copyright © 2020  huangyikun. All rights reserved.
//  CALayer的学习

import UIKit

class ClockVC: UIViewController {
    
    lazy var clock : CALayer = {
        let c = CALayer.init()
        c.frame = .init(x: 0, y: 0, width: 200, height: 200)
        c.position = .init(x: 200, y: 400)
        c.contents = UIImage.init(named: "clock")?.cgImage
        return c
    }()
    
    lazy var second : CALayer = {
        let c = CALayer.init()
        c.frame = .init(x: 0, y: 0, width: 2, height: 100)
        c.position = clock.position
        c.backgroundColor = UIColor.red.cgColor
        c.anchorPoint = .init(x: 0, y: 0.8)
        return c
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CALayer的学习"
        view.backgroundColor = UIColor.white

        self.view.layer.addSublayer(clock)
        view.layer.addSublayer(second)
        
        //定时器
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
        //跟屏幕刷新屏幕一样的定时器
        let cdl = CADisplayLink.init(target: self, selector: #selector(timeChange))
        cdl.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
    }
    
    @objc
    private func timeChange() {
        //第一种获取秒数
        let date = Date.init()
//        let formatter = DateFormatter.init()
//        formatter.dateFormat = "ss"
//        let secondTime : CGFloat = CGFloat(Float(formatter.string(from: date))!)
        //第二种获取秒数
        let cal = NSCalendar.current
        let secondTime : CGFloat = CGFloat(cal.component(Calendar.Component.second, from: date))
        
        //旋转
        let angle = CGFloat.pi * 2 / 60
//        second.setAffineTransform(second.affineTransform().rotated(by: angle))
        second.setAffineTransform(CGAffineTransform.init(rotationAngle: angle*secondTime))
    }
}
