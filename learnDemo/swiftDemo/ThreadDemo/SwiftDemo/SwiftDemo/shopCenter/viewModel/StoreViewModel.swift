//
//  StoreViewModel.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/13.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class StoreViewModel: NSObject {

    
    func loadItemData(loadFinish : ((Bool,NSArray) -> Void)){
        let list = NSMutableArray()
        let plistPath = Bundle.main.path(forResource: "item.plist", ofType: nil)
           let arrays : NSArray = NSArray(contentsOfFile: plistPath!)!
           for index  in arrays{
               let model = StoreModel(dict : index as! NSDictionary)
                list.add(model)
           }
        if(list.count > 0){
            loadFinish(true,list)
        }else{
            loadFinish(false,list)
        }
    }
    
    //闭包
//    func load(loadFinish : ((Bool)->Void)){
//        loadFinish
//    }
//
//    //使用闭包
//    func use(){
//        load {
//            (complete:Bool)->Void in
//            if(complete){
//                print("回调成功")
//            }
//        }
//    }
    
//    public func loadData(){
//        let plistPath = Bundle.main.path(forResource: "item.plist", ofType: nil)
//        let array = NSArray(contentsOfFile: plistPath!)
////        for dict in array {
////            print("dice \(dict)")
////        }
//
//
////        NSArray(contentsOfFile: plistPath ?? "")
////        if(plistPath != nil){
////            NSArray(contentsOfFile: plistPath)
////        }
//    }
}
