//
//  UIDrawVc.swift
//  SwiftDemo
//
//  Created by Yk Huang on 2020/10/14.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

class UIDrawVc: UIViewController {
    
    lazy var imageview : UIImageView = {
        let iv = UIImageView.init(frame: .init(x: 0, y: 300, width: 300, height: 300))
        iv.backgroundColor = UIColor.yellow
        self.view.addSubview(iv)
        return iv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "自定义控件的绘制"
        
        
        //画各种形状的view
        let tv = UITestView.init(frame: self.view.bounds)
        self.view.addSubview(tv)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        userImgContext()
//        if let img = UIImage.init(named: "baqi") {
//            save2Album(img: img)
//        }
        
        //自定义各种形状的的imageview
        if let img = UIImage.init(named: "cat") {
            self.view.addSubview(MyImageView.init(img: img,type: 1))
        }
        drawWaterMark()
        screenShot()
    }
    
    private func userImgContext(){
        /***图片的上下文**/
        //开启图片类型的图形上下文，方法一,固定死了上下文大小，第二种方式动态设置大小，一般使用第二种方式
//        UIGraphicsBeginImageContext(.init(width: 300, height: 300))
        
        /***开启图片类型的图形上下文，方法二,(第三个参数设置了0和设置UIScreen.main.scale一样，上下文会根据
        屏幕大小而进行改变大小，会乘以对应的倍率，1X，2X，3X这样子的)
         */
        UIGraphicsBeginImageContextWithOptions(.init(width: 300, height: 300), false, 0)
        //获取当前的上下文（图片类型）
        if let ctx = UIGraphicsGetCurrentContext() {
            //拼接路径，并且添加到上下文中
            ctx.move(to: .init(x: 40, y: 50))
            ctx.addLine(to: .init(x: 100, y: 100))
            ctx.addLine(to: .init(x: 200, y: 50))
            //渲染
            ctx.strokePath()
            
            //通过图片类型的图形上下文，获取图片对象(获取的是图片上下文中的内容，也就是上面所添加的路径，跟背景颜色什么的都没有关系)
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                self.imageview.image = image
                save2Sandbox(img: image)
            }
            self.imageview.backgroundColor = UIColor.yellow
            //关闭图片类型的图形上下文
            UIGraphicsEndImageContext()
        }
    }
    
    /**
     屏幕截图
     */
    private func screenShot() {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            //把view的内容放到上下文中，然后渲染，就可以通过下面的上下文来得到image
            self.view.layer.render(in: ctx)
        }
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)
        
        UIGraphicsEndImageContext()
    }
    
    /***
     画水印，生成图片*/
    private func drawWaterMark() {
        //本来的图片
        let img = UIImage.init(named: "cat")
        //设置的水印图片
        let logoImg = UIImage.init(named: "logo")
        //设置的水印文字
        let logoTxt : NSString = "be stronger"
        
        //开启图片上下文
        UIGraphicsBeginImageContextWithOptions(img!.size, false, 0)
        //画图片
        img?.draw(at: .zero)
        //画水印文字
        logoTxt.draw(at: CGPoint.init(x: 20, y: 20), withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40)])
        //画水印图片
        logoImg?.draw(at: .init(x: (img?.size.width)!*0.5, y: (img?.size.height)!*0.5))
        //获取一起渲染后的图片
        if let newImg = UIGraphicsGetImageFromCurrentImageContext() {
            //显示到界面上
            self.imageview.image = newImg
            
            //保存到相册
            UIImageWriteToSavedPhotosAlbum(newImg, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        
        //关闭图片上下文
        UIGraphicsEndImageContext()
        
    }
    
    /**
     保存image到沙盒中
     */
    private func save2Sandbox(img : UIImage) {
        //获取沙盒路径
        //第一种获取沙盒路径方式
//        print("home"+NSHomeDirectory())
//        let docPath = NSHomeDirectory()+"/Document"
        
        //第二种获取沙盒路径方式
        if let docPath : String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first {
            let filePath : String = docPath + "/test.png"
            
            print("path:",filePath)
            //把image对象转化成nsDate
            if let imgData = img.pngData() {
                //通过nsData的writeToFile写入到沙盒中
                let fileUrl = URL.init(fileURLWithPath: filePath)
                do {
                    try imgData.write(to: fileUrl, options: Data.WritingOptions.atomicWrite)
                } catch  {
                    print("写入失败")
                }
            }
        }
    }
    
    /***
     通过图片上下文获取image保存到相册中*/
    private func save2Album(img:UIImage) {
        //开启图片上下文
        UIGraphicsBeginImageContextWithOptions(img.size, false, 0)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            //画圆
            ctx.addArc(center: .init(x: img.size.width*0.5, y: img.size.width*0.5), radius: img.size.width*0.5, startAngle: 0, endAngle: .pi*2, clockwise: true)
            //裁剪，让渲染区域是上面的画出来的圆形
            ctx.clip()
            
            //把图片画上去,因为在上面设置了渲染区域位圆形，所以这时候画上去的图片只会渲染圆形，所以下面一步获取的就是圆形的图片
            img.draw(at: .zero)
            
            //取出来渲染的圆形的image
            if let newImg = UIGraphicsGetImageFromCurrentImageContext() {
                self.imageview.image = newImg
                
                //保存到相册
                UIImageWriteToSavedPhotosAlbum(newImg, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
            
            ctx.fillPath()
            
            
        }
        
        //关闭图片上下文
        UIGraphicsEndImageContext()
    }
    
    //MARK:- 保存到相册的回调
    @objc
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            print("错误")
            return
        }
        print("OK")
    }
    
}
