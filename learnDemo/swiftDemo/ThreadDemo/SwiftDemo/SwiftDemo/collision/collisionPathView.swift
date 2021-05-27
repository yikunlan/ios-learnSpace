//
//  collisionPathView.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/20.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class collisionPathView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath.init()
        
        path.move(to: .init(x: 0, y: 200))
        path.addLine(to: .init(x: 200, y: 300))
        path.stroke()
    }

}
