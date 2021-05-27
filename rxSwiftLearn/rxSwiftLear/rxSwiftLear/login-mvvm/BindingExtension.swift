//
//  BindingExtension.swift
//  RxSwiftDemo
//
//  Created by Yk Huang on 2021/5/13.
//  绑定Viewmodel的时候需要的一些扩展类

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        // result 是ValidationResult的范型,label是base的范型，而base是UILabel类型的
        return Binder<ValidationResult>.init(base) { (label, result) in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}
