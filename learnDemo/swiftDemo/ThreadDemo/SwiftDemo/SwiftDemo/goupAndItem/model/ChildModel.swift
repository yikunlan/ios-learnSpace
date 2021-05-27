//
//  ChildModel.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/20.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class ChildModel: NSObject {
    var url : String = ""
    var newName : String = ""
    var oldName : String?
    var isFavorite : Bool = false
    
    init(url : String , newName : String , oldName : String , isFavorite : Bool?) {
        super.init()
        
        self.url = url
        self.newName = newName
        self.oldName = oldName
        if let fav = isFavorite{
            self.isFavorite = fav
        }
    }
    

}
