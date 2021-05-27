//
//  ShopCenterMainVC.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/13.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class ShopCenterMainVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    let cellId = "cell_id"
    let headID = "head_id"
    let footId = "foot_id"
    var dataList : NSArray?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    private func initData(){
        let viewModel = StoreViewModel()
        viewModel.loadItemData { (complete:Bool, list : NSArray) in
            if(complete){
                dataList = list
                initView()
            }else{
                print("加载数据失败")
            }
        }
    }
    
    func initView(){
        title = "商店页面"
        let flowLayout = UICollectionViewFlowLayout()
        //设置滚动方向
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        //设置item大小
        flowLayout.itemSize = CGSize(width: (CommonUtil.screenWidth - 20*3)/2, height: CommonUtil.screenHeight/3)
        //设置item间距
        flowLayout.minimumInteritemSpacing = 20
        //设置列间距
        flowLayout.minimumLineSpacing = 20
        //设置colletionView的内边距
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        //注册头部
        collection.register(StoreHeadView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: headID)
        flowLayout.headerReferenceSize = CGSize(width: CommonUtil.screenWidth, height: 200)
        //注册底部
        collection.register(StoreHeadView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footId)
        flowLayout.footerReferenceSize = CGSize(width: CommonUtil.screenWidth, height: 200)
        //注册cell
        collection.register(StoreCell.self, forCellWithReuseIdentifier: cellId)

        view .addSubview(collection)
    }
    

 // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        var reuseableView : UICollectionReusableView!
        if(kind == UICollectionView.elementKindSectionHeader){
            reuseableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headID, for: indexPath)
            reuseableView.backgroundColor = UIColor.yellow
        }else if(kind == UICollectionView.elementKindSectionFooter){
            reuseableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footId, for: indexPath)
            reuseableView.backgroundColor = UIColor.green
        }
        print("kind : \(kind)")
        return reuseableView;
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : StoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoreCell
        cell.setModel(model: dataList?[indexPath.row] as! StoreModel)
        return cell
    }
    
    //点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: String("title"), message: String("点击了第 \(indexPath.row) 个"), preferredStyle: UIAlertController.Style.actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
//        alert.show(self, sender: nil)
     
    }
}
