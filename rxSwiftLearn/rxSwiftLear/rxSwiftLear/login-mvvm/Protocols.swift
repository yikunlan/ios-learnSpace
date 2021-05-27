//
//  Protocols.swift
//  RxSwiftDemo
//
//  Created by Yk Huang on 2021/5/11.
// 面向协议编程，虽然写的不习惯，慢慢适应吧

import Foundation
import RxCocoa
import RxSwift

enum ValidationResult {
    case ok(msg: String)
    case empty
    case validating
    case failed(msg: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case .validating:
            return "validating ..."
        case let .failed(message):
            return message
        }
    }
}
struct ValidationColors {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}
extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColors.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColors.errorColor
        }
    }
}

protocol ValidationService {
    func validateUsername(userName: String) -> Observable<ValidationResult>
    func validatePassword(password: String) -> ValidationResult
    func validateRepeatPassword(_ password: String, repeatPassword: String) -> ValidationResult
}

protocol API {
    func usernameAvailable(username: String) -> Observable<Bool>
    func signup(username: String, password: String) -> Observable<Bool>
}
