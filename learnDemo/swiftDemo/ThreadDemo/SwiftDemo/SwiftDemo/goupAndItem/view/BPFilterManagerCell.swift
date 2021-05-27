//
//  BPFilterManagerCell.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/21.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class BPFilterManagerCell: UITableViewCell {
    
    @IBOutlet weak var filterIcon: UIImageView!
    @IBOutlet weak var fiterNewName: UILabel!
    @IBOutlet weak var filterOldName: UILabel!
    
    @IBOutlet weak var btnFavorite: UIButton!
    
    var isFavorite = false;
    @IBAction func addFavorite(_ sender: Any) {
        isFavorite = !isFavorite
        if(isFavorite){
            btnFavorite.setTitle("已收藏", for: UIControl.State.normal)
        }else{
            btnFavorite.setTitle("收藏", for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        selectionStyle = UITableViewCell.SelectionStyle.gray
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(model : ChildModel){
        filterIcon.image = UIImage.init(named: model.url)
        filterOldName.text = model.oldName
        fiterNewName.text = model.newName
    }
    
}
