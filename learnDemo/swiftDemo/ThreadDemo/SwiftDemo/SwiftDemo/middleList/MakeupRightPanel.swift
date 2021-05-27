//
//  MakeupRightPanel.swift
//  BeautyPlus
//
//  Created by  huangyikun on 2020/7/7.
//  Copyright © 2020 美图网. All rights reserved.
//

import UIKit

class MakeupRightPanel: UIView {
    let unableSelectedIndex = -1
    let cellId = "cellId"
    let itemMaxWidth = 35
    let itemWidth = 23
    var middleIndex = 2
    let collectionHeight = 210
    let collectionWidth = 60
    var isAdd = false
    var isRest = false
    
    var collection: UICollectionView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initView(){
        let flowLayout = UICollectionViewFlowLayout()
        //设置滚动方向
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        //设置item间距
        flowLayout.minimumInteritemSpacing = 16
        //设置列间距
        flowLayout.minimumLineSpacing = 16
        //设置colletionView的内边距
        let topPadding = CGFloat((collectionHeight - itemMaxWidth) / 2)
        flowLayout.sectionInset = UIEdgeInsets(top: topPadding, left: 0, bottom: topPadding, right: 0)
        
        let collctionFrame = CGRect(x: 0, y: 0, width: collectionWidth, height:collectionHeight)
        let clc = UICollectionView(frame: collctionFrame, collectionViewLayout: flowLayout)

        clc.backgroundColor = UIColor.red
        clc.dataSource = self
        clc.delegate = self
        //注册cell
        clc.register(UINib.init(nibName: "MakeupRightPanelCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collection = clc
        addSubview(clc)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.isRest = false
            self.middleIndex = 2
            self.updateMiddleView(index: self.middleIndex)
        }
    }
        
    private func updateMiddleView(index: NSInteger) {
        if middleIndex < 0 {
            return
        }
        let indexPath = IndexPath.init(row: index, section: 0)

        if let clc = collection {
            if !clc.isDragging {
                clc.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
            }
            if isRest {
                middleIndex = unableSelectedIndex
            }
            clc.reloadItems(at: [indexPath])
        }
    }
    
}

// MARK: UICollectionViewDataSource,UICollectionViewDelegate 协议
extension MakeupRightPanel : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MakeupRightPanelCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MakeupRightPanelCell
        cell.tag = indexPath.row
        cell.selected(isSelected: isRest ? false : (indexPath.row == middleIndex),
                      middleWidth: CGFloat(itemMaxWidth),
                      normalWidth: CGFloat(itemWidth))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        middleIndex = indexPath.row
        updateMiddleView(index: indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let isMiddle = indexPath.row == middleIndex

        if let cell: MakeupRightPanelCell = collection?.cellForItem(at: indexPath) as? MakeupRightPanelCell {
            cell.selected(isSelected: isRest ? false : isMiddle,
                          middleWidth: CGFloat(itemMaxWidth),
                          normalWidth: CGFloat(itemWidth))
        }
        return (isMiddle && !isRest) ?
        CGSize(width: itemMaxWidth, height: itemMaxWidth):
            CGSize(width: itemWidth, height: itemWidth)
    }

}

// MARK: UIScrollView 协议
extension MakeupRightPanel : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isRest = true
        if let cell: MakeupRightPanelCell = collection?.cellForItem(at: IndexPath(item: middleIndex, section: 0)) as? MakeupRightPanelCell {
            cell.selected(isSelected: false,
                          middleWidth: CGFloat(itemMaxWidth),
                          normalWidth: CGFloat(itemWidth))
        }
    }

     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let clc = collection {
            let array = clc.visibleCells
            for cell in array {

                let frame = clc.convert(cell.frame, to: self)
                if frame.contains(.init(x: frame.origin.x+2, y: clc.frame.midY)){
                    middleIndex = cell.tag

                    isRest = false
                }
                
                if (!isAdd) {
                    let middleView = UIView.init(frame: .init(x: frame.origin.x, y: clc.frame.midY, width: 100, height: 2))
                    middleView.backgroundColor = UIColor.black
                    self.addSubview(middleView)
                }
            }
        }
        
     }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollToScrollStop = !scrollView.isTracking &&
            !scrollView.isDragging &&
            !scrollView.isDecelerating
        if scrollToScrollStop {
            stopScroll()
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let dragToDragStop = scrollView.isTracking &&
                !scrollView.isDragging &&
                !scrollView.isDecelerating
            if dragToDragStop {
                stopScroll()
            }
        }
    }

    private func stopScroll() {
        isRest = false
        updateMiddleView(index: middleIndex)
    }
}
