//
//  DrawView.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/16.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class DrawView: UIView {


    
    var lineWidth : CGFloat = 5
    
    var lineColor : UIColor  = UIColor.black
    
    lazy var pathArray : NSMutableArray = {
        let a = NSMutableArray.init()
        return a
    }()
    
    
    public func clear() {
        pathArray.removeAllObjects()
        setNeedsDisplay()
    }
    
    public func back() {
        pathArray.removeLastObject()
        setNeedsDisplay()
    }
    
    public func eraser() {
        if let color = self.backgroundColor {
            lineColor = color
        }
    }
    /***保存到相册
     */
    public func save2Album() {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            self.layer.render(in: ctx)
            
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
            }
        }
        UIGraphicsEndImageContext()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            let position = t.location(in: t.view)
            
            let path = UIBezierPath.init()
            path.lineWidth = lineWidth
            path.lineColor = lineColor
            path.move(to: position)
            path.lineJoinStyle = .round
            path.lineCapStyle = .round
            pathArray.add(path)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            let position = t.location(in: t.view)
            (pathArray.lastObject as! UIBezierPath).addLine(to: position)
            
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if (pathArray.count > 0) {
            pathArray.forEach { (path) in
                let p = (path as! UIBezierPath)
                p.lineColor.setStroke()
                p.stroke()
            }
            
        }
    }
    
}

extension UIBezierPath {
    
    private struct AssociatedKey {
        static var lineColor : UIColor = UIColor.black
    }
    
    public var lineColor : UIColor {
        get{
            let color = objc_getAssociatedObject(self, &AssociatedKey.lineColor)
            return color as! UIColor
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKey.lineColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}
