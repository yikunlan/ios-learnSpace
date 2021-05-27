//
//  DrawBoardVC.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/16.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class DrawBoardVCBoard: UIViewController {

    @IBOutlet weak var drawView: DrawView!

    @IBAction func clear(_ sender: Any) {
        drawView.clear()
    }
    
    @IBAction func back(_ sender: Any) {
        drawView.back()
    }
    
    @IBAction func eraser(_ sender: Any) {
        drawView.eraser()
        
    }
    @IBAction func save(_ sender: Any) {
        drawView.save2Album()
        
    }
    
    
    @IBAction func changeLineWIdth(_ sender: UISlider) {
        drawView.lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func changeLineColor(_ sender: UIButton) {
        drawView.lineColor = sender.backgroundColor!
    }
    
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}
