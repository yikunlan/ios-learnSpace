//
//  AngryBGView.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/22.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class AngryBGView: UIView {
    
    var path : UIBezierPath?

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        path?.stroke()
    }

}
