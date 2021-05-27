// 中间大两边小的滚动
//  MiddleListVC.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/7/6.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class MiddleListVC: UIViewController {
    
    let cellId = "cellId"
    let itemMaxWidth = 35
    let itemWidth = 30
    var middleIndex = -1
    var isAdd = false
    var isRest = true
    
    var collection: UICollectionView?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let panel = MakeupRightPanel.init(frame: CGRect.init(x: 100, y: 200, width: 100, height: 300))
        panel.backgroundColor = UIColor.green
        self.view.addSubview(panel)
    }
    
//
//    func initView(){
//        title = "轮子页面"
//        let flowLayout = UICollectionViewFlowLayout()
//        //设置滚动方向
//        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
//        //设置item大小
////        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
//        //设置item间距
//        flowLayout.minimumInteritemSpacing = 10
//        //设置列间距
//        flowLayout.minimumLineSpacing = 10
//        //设置colletionView的内边距
//        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//
//        let collctionFrame = CGRect(x: 100, y: 200, width: 50, height:210)
//        let clc = UICollectionView(frame: collctionFrame, collectionViewLayout: flowLayout)
//
//        clc.backgroundColor = UIColor.red
//        clc.dataSource = self
//        clc.delegate = self
//        //注册cell
//        clc.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
//        collection = clc
//        view .addSubview(clc)
//    }
//
//    private func updateMiddleView(isReset: Bool) {
//        if middleIndex == -1 {
//            return
//        }
//        let indexPath = IndexPath.init(row: middleIndex, section: 0)
//        if let clc = collection {
//            if !clc.isDragging {
//                collection?.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
//            }
//            collection?.reloadItems(at: [indexPath])
//        }
//
//    }
//
}

// MARK: UICollectionViewDataSource,UICollectionViewDelegate 协议
//
//extension MiddleListVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        cell.backgroundColor = UIColor.yellow
//        cell.tag = indexPath.row
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == middleIndex {
//            return isRest ? CGSize.init(width: itemWidth, height: itemWidth) :
//                CGSize.init(width: itemMaxWidth, height: itemMaxWidth)
//        } else {
//            return CGSize.init(width: itemWidth, height: itemWidth)
//        }
//
//    }
//
//}
//
//// MARK: UIScrollView 协议
// extension MiddleListVC : UIScrollViewDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        isRest = true
//        updateMiddleView(isReset: isRest)
//    }
//
//     func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if let clc = collection {
//            let array = clc.visibleCells
//            for cell in array {
//                let frame = clc.convert(cell.frame, to: self.view)
//                if frame.contains(.init(x: frame.origin.x+2, y: clc.frame.midY)){
//                    middleIndex = cell.tag
//
//                    isRest = false
//                    updateMiddleView(isReset: isRest)
//                }
//
//                if (!isAdd) {
//                    let middleView = UIView.init(frame: .init(x: frame.origin.x, y: clc.frame.midY, width: 100, height: 2))
//                    middleView.backgroundColor = UIColor.black
//                    self.view.addSubview(middleView)
//                }
//            }
//        }
//
//     }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let scrollToScrollStop = !scrollView.isTracking &&
//            !scrollView.isDragging &&
//            !scrollView.isDecelerating
//        if scrollToScrollStop {
//            stopScroll()
//        }
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            let dragToDragStop = scrollView.isTracking &&
//                !scrollView.isDragging &&
//                !scrollView.isDecelerating
//            if dragToDragStop {
//                stopScroll()
//            }
//        }
//    }
//
//    private func stopScroll() {
//        print("end:",middleIndex)
////        let indexPath = IndexPath.init(row: middleIndex, section: 0)
////        collection?.reloadItems(at: [indexPath])
//        isRest = false
//        updateMiddleView(isReset: isRest)
//    }
// }
