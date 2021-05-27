//
//  StoreCell.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/13.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class StoreCell: UICollectionViewCell {
    var img : UIImageView?
    var title : UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 40))
        title = UILabel(frame: CGRect(x: 0, y: frame.size.height - 40, width: frame.size.width, height: 40))
        title?.textAlignment = NSTextAlignment.center
        
        if let img = img{
            addSubview(img)
            //设置圆角
            img.layer.cornerRadius = 20
            img.layer.masksToBounds = true
        }else{
            print("唯恐没有添加1111")
        }
        addSubview(title!)
    }
    
    func setModel(model:StoreModel){
        img?.image = UIImage.init(named: model.url)
        title?.text = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
