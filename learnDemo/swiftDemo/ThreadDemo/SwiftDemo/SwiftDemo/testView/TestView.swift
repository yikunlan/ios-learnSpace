//
//  TestView.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/7/23.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class TestView: UIView {

    @IBOutlet weak var iv: UIImageView!
    
    override func awakeFromNib() {
        initView()
    }

    func initView() {
        self.backgroundColor = UIColor.yellow
        iv.backgroundColor = UIColor.yellow
    }

}
