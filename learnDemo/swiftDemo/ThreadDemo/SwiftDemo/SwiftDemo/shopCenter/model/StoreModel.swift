//
//  StoreModel.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/13.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class StoreModel: NSObject {
    var title : String = ""
    var url : String = ""
    
    init(dict : NSDictionary) {
        title = dict.object(forKey: "title") as! String
        url = dict.object(forKey: "url") as! String
        //todo 看看是否可以使用系统提供方法，比如oc的
//        [self setValuesForKeysWithDictionary:dict];
    }

}
