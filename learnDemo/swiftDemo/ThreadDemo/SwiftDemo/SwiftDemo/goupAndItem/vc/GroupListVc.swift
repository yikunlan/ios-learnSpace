//
//  GroupListVc.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/20.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class GroupListVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let cellId = "cell_id"
    var groupList : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "滤镜管理"
         
        initData()
        initView()
    }
    
    private func initData(){
        if(groupList == nil){
            groupList = NSMutableArray()
            
            for i  in 0...2 {
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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: CommonUtil.screenWidth, height: 120)
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.delegate = self
        cv.dataSource = self
        
        view.addSubview(cv)
    }
    
// MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupList?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = (groupList?[section])! as! GroupModel
        return group.childrenList?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section {
//        case 0:
//            let g as GroupModel
//        let group1 = grouList?[indexPath.section]
//        default:
//            break
//        }
//        let group = (grouList?[indexPath.section])! as! GroupModel
        
//        if(grouList?[indexPath.section] is GroupModel){
//            let group =
//        }
//        return (grouList?[indexPath.section] as GroupModel)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        switch indexPath.section {
        case 0:
          cell.backgroundColor = UIColor.green
          case 1:
            cell.backgroundColor = UIColor.blue
            case 2:
              cell.backgroundColor = UIColor.yellow
        default:
          cell.backgroundColor = UIColor.black
        }
        return cell
    }
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return ["组的标题？？" ,"标题1"]
//        let group = (groupList?[section])! as! GroupModel
//        return group.title
    }
    
}
