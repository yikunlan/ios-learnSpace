//
//  ableViewVC.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/21.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit
import SnapKit

class TableViewVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cell_id"
    
    var groupList : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initView()
    }
    
    private func initData(){
        if(groupList == nil){
            groupList = NSMutableArray()
            
            for i  in 0...10 {
                let g1 = GroupModel()
                g1.title = "分类\(i)"

                let children = NSMutableArray()
                let c = ChildModel(url: "item.jpg", newName: "new1", oldName: "old1", isFavorite: nil)
                let c2 = ChildModel(url: "head.jpg", newName: "new2", oldName: "old2", isFavorite: nil)
                let c3 = ChildModel(url: "baby.jpg", newName: "new3", oldName: "old3", isFavorite: nil)
                children.add(c)
                children.add(c3)
                children.add(c2)
                
                g1.childrenList = children

                groupList?.add(g1)
            }
        }
    }
    private func initView(){

        let tv = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tv.dataSource = self
        tv.delegate = self
        //设置标题的宽度
        tv.sectionHeaderHeight = 30
        tv.sectionFooterHeight = 0
        
        //设置item高度
        tv.rowHeight = 40
        
        tv.register(UINib(nibName: "BPFilterManagerCell", bundle:Bundle.main), forCellReuseIdentifier: cellId)
        //去掉item之间分割线
        tv.separatorStyle = UITableViewCell.SeparatorStyle.none
        
//        //编辑状态
//        tv.setEditing(true, animated: true)
//        //设置是否多选
//        tv.allowsMultipleSelection = true;
//        tv.allowsSelectionDuringEditing = true;
//        tv.allowsMultipleSelectionDuringEditing = true;
        
        view.addSubview(tv)
    }
    
    //显示几组数据
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupList?.count ?? 1
    }
    
    //每组数据都有几个子item
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = (groupList?[section])! as! GroupModel
        return group.childrenList?.count ?? 1
    }
    
    //每个item展示的样式
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BPFilterManagerCell
        let group = groupList[indexPath.section] as! GroupModel
        let model = group.childrenList?[indexPath.row] as! ChildModel
        cell.setModel(model:model)
        return cell
    }
    
    //每组标题
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let group = (groupList?[section])! as! GroupModel
//        return group.title
//    }
    //组头的view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rootView = UIView(frame: CGRect(x: 0, y: 0, width: CommonUtil.screenWidth, height: 30))
        rootView.backgroundColor = UIColor.white
        let title = UILabel()
        title.text = (groupList?[section] as! GroupModel).title
        
        let line = UIView()
        line.backgroundColor = UIColor.yellow
        
        rootView.addSubview(title)
        rootView.addSubview(line)
        
        title.snp_makeConstraints { (make) in
            make.top.equalTo(rootView.snp_top)
            make.left.equalTo(rootView.snp_left).offset(15)
            make.height.equalTo(20)
        }
        line.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom).offset(8)
            make.left.equalTo(rootView.snp_left).offset(15)
            make.right.equalTo(rootView.snp_right).offset(-15)
            make.height.equalTo(1)
        }
        
 
        return rootView;
    }
    
    //返回编辑模式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
//        return UITableViewCell.EditingStyle.insert

    }
    
    //提交删除操作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            print("删除的第几组\(indexPath.section)")
            //删除数据
            let group = groupList[indexPath.section] as! GroupModel
            group.childrenList?.removeObject(at: indexPath.row)
            if(group.childrenList!.count <= 0){
                groupList.remove(group)
            }
            tableView.reloadData()
        }
    }
    
    //设置删除的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "delete"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消选中，这样做的效果就是点击的时候颜色加深，然后放手后恢复
        tableView .deselectRow(at: indexPath, animated: true)
    }

}
