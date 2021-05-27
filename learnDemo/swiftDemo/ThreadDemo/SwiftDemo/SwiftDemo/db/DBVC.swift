//
//  DBVC.swift
//  SwiftDemo
//一个FMDB数据库的简单实用用例
//FMDB 是 iOS 平台的 SQLite 数据库框架
//FMDB 以 OC 的方式封装了 SQLite 的 C 语言 API
//引入：pod 'FMDB'

//  Created by  huangyikun on 2020/7/16.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class DBVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LKDBHelper.init(dbName: "testdbname")
        initView()
        queryAll()
    }
    
    func initView() {
        title = "db的简单实用"
        view.backgroundColor = .white
             
        let addBtn = UIButton(frame: CGRect(x: 50, y: 70, width: 100, height: 40))
        addBtn.setTitle("增加", for: UIControl.State.normal)
        addBtn.setTitleColor(.blue, for: .normal)
        addBtn.backgroundColor = .yellow
        addBtn.addTarget(self, action: #selector(add2DB(_:)), for: .touchUpInside)
        view.addSubview(addBtn)


        let delBtn = UIButton(frame: CGRect(x: 170, y: 70, width: 100, height: 40))
        delBtn.setTitle("删除", for: UIControl.State.normal)
        delBtn.setTitleColor(.blue, for: .normal)
        delBtn.addTarget(self, action: #selector(delFromDB(_:)), for: .touchUpInside)
        delBtn.backgroundColor = .red
        view.addSubview(delBtn)
    }
    
    private func queryAll() {
        let txtLable = UILabel.init(frame: CGRect(x: 0, y: 100, width: 500, height: 700))
        txtLable.textColor = UIColor.black
        txtLable.numberOfLines = 0
        view.addSubview(txtLable)
        var modelString = ""
        
        let allArray : [LKModel] = LKModel.search(withWhere: nil) as! [LKModel]
        allArray.forEach { (model) in
            
            modelString.append("name:")
            modelString.append(model.name)
            modelString.append(",age:")
            modelString.append((model.age as NSNumber).stringValue)
            modelString.append("/")
        }
        txtLable.text = modelString
    }
    
    
    @objc
    private func add2DB(_ sender: UIButton) {
        var modelArray : [LKModel] = []
        for i in 1...5 {
            let model = LKModel.init()
            let name = String.init(format: "张三", i)
            model.name = name
            model.age = 20*i
            modelArray.append(model)
        }
//        LKDBHelper().setDBName("DbTest")
        
        LKModel.insertToDB(with: modelArray, filter: nil) { (result) in
            print("增加成功")
            print("表名称：",LKModel.getTableName())
        }
    }
    
    @objc
    private func delFromDB(_ sender: UIButton) {
        
        let allArray : [LKModel] = LKModel.search(withWhere: nil) as! [LKModel]
        allArray.forEach { (model) in
            model.deleteToDB()
        }
        print("删除")
    }

}
