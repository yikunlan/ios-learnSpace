//
//  Wireframe.swift
//  RxSwiftDemo
//
//  Created by Yk Huang on 2021/5/12.
//

import RxSwift
import UIKit

protocol Wireframe {
    func open(url: URL)
    //CustomStringConvertible:可以自定义输出的格式类型
    func promptFor<T: CustomStringConvertible>(_ msg: String, cancelAction: T, actions: [T]) -> Observable<T>
}

class DefaultWireframe: Wireframe {
    
    static let alertTitle = "MyAlert"
    
    static let shared = DefaultWireframe()
    
    
    func open(url: URL) {
        UIApplication.shared.open(url)
    }
    
    private static func rootViewController() -> UIViewController {
        return UIApplication.shared.keyWindow!.rootViewController!
    }
    
    static func presentAlert(_ msg: String) {
        let alertVIew = UIAlertController(title: alertTitle, message: msg, preferredStyle: .alert)
        alertVIew.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            
        }))
        rootViewController().present(alertVIew, animated: true, completion: nil)
    }
    
    func promptFor<T>(_ msg: String, cancelAction: T, actions: [T]) -> Observable<T> where T : CustomStringConvertible {
        return Observable.create { (observer) -> Disposable in
            let alertView = UIAlertController(title: DefaultWireframe.alertTitle, message: msg, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: cancelAction.description, style: .cancel, handler: { (_) in
                observer.on(.next(cancelAction))
            }))
            
            actions.forEach { (action) in
                alertView.addAction(UIAlertAction(title: action.description, style: .default, handler: { (_) in
                    observer.on(.next(action))
                }))
            }
            
            DefaultWireframe.rootViewController().present(alertView, animated: true, completion: nil)
            return Disposables.create{ alertView.dismiss(animated: true, completion: nil) }
        }
    }
}


enum RetryResult {
    case retry
    case cancel
}

extension RetryResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .retry:
            return "Retry"
        case .cancel:
            return "Cancel"
        }
    }
}
