//
//  CirclePathView.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/16.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class CirclePathView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        UIBezierPath.init(arcCenter: .init(x: 100, y: 100), radius: 100, startAngle: 0, endAngle: .pi*2, clockwise: true).stroke()
    }

}
