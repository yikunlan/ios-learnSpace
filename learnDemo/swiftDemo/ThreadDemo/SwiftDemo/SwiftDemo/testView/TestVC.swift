//
//  TestVC.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/7/23.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class TestVC: UIViewController {
    
    lazy var contentView : TestView = {
        let view : TestView = Bundle.main.loadNibNamed("TestView", owner: self, options: nil)?.first as! TestView
        view.frame = CGRect(x: 100, y: 200, width: 50, height: 50)
        view.backgroundColor = UIColor.green
        return view
    }()
    
//    lazy var arcView : ArcView = {
//        let a = ArcView.init(frame: .init(x: 0, y: 200, width: view.frame.width, height: 400))
//        a.backgroundColor = .red
//        return a
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
//        view.addSubview(arcView)
 
    }
    
    @objc
    private func actionBtn(_ sender: UIButton) {
        contentView.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
    }

}
