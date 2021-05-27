//
//  StoreHeadView.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/14.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class StoreHeadView: UICollectionReusableView {

    let colorArray = [UIColor.yellow,UIColor.blue,UIColor.gray,UIColor.green]
    var colorIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (time : Timer) in
            self.backgroundColor = self.colorArray[self.colorIndex];
            self.colorIndex += 1
            if(self.colorIndex>=self.colorArray.count){
                self.colorIndex = 0
            }
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
