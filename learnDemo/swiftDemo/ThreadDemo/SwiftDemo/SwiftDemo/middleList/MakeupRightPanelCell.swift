//
//  MakeupRightPanelCell.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/7/7.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class MakeupRightPanelCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var contentImgWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentImgHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        initView()
    }
       
   required init?(coder: NSCoder) {
        super.init(coder: coder)
   }

    func initView() {
        contentImage.image = UIImage.init(named: "baby.jpg")
        contentImage.contentMode = .scaleAspectFill
        contentImage.clipsToBounds = true
        
        contentImage.layer.masksToBounds = true
    }
    
    func selected(isSelected: Bool,middleWidth: CGFloat,normalWidth: CGFloat) {
         let width = CGFloat(isSelected ? middleWidth : normalWidth)
         //之所以也要设置self.layer的radius是为了防止在改变image大小变化的过程中出现正方形的情况
         self.layer.masksToBounds = true
         self.layer.cornerRadius = width/2
         
         contentImage.layer.cornerRadius = width/2
         if (contentImgWidthConstraint.constant != width) {
             contentImgWidthConstraint.constant = width
             contentImgHeightConstraint.constant = width
         }
     }
    
}
