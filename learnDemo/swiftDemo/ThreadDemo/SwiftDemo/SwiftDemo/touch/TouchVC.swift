//
//  TouchVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/14.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class TouchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        self.title = "触摸事件的学习"
        
        //划屏幕可以画线的控件
        let bgView = TouchBGView.init(frame: self.view.bounds)
//        bgView.backgroundColor = UIColor.red
        bgView.isUserInteractionEnabled = true
        view.addSubview(bgView)
        //触摸可以移动的控件
        let tv = TouchTestView.init(frame: .init(x: 50, y: 80, width: 50, height: 50))
        tv.backgroundColor = UIColor.yellow
        view.addSubview(tv)
        //手势解锁的控件
        let centerPoint = self.view.center
        let width : CGFloat = 300
        let spv = SudokuPwdView.init(frame: .init(x: centerPoint.x - width/2, y: centerPoint.y - width/2, width: width, height: width))
        //一定要设置背景颜色,不能不设置，要不然会有奇怪的问题，线画的奇奇怪怪的
        spv.backgroundColor = UIColor.clear
        view.addSubview(spv)
    }
    
}
