//
//  DefaultImplementations.swift
//  RxSwiftDemo
//
//  Created by Yk Huang on 2021/5/13.
//  放一些协议的默认实现

import Foundation
import RxSwift

class DefaultValidationService: ValidationService {
    
    let api: API
    
    let minPasswordCount = 6
    
    static let sharedValidationService = DefaultValidationService(api: DefaultAPI.shareAPI)
    
    init(api: API) {
        self.api = api
    }
    
    func validateUsername(userName: String) -> Observable<ValidationResult> {
        if userName.isEmpty {
            return .just(.empty)
        }
        if userName.count < minPasswordCount {
            return .just(.failed(msg: "letter length less than \(minPasswordCount)"))
        }
        
        if userName.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(msg: "username can only contain numbers or digits"))
        }
        
        let loadingValue = ValidationResult.validating
        
        return api.usernameAvailable(username: userName)
            .map { available in
                if available {
                    return .ok(msg: "username available")
                } else {
                    return .failed(msg: "username already taken")
                }
            }.startWith(loadingValue)
    }
    
    func validatePassword(password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(msg: "password must be at least \(minPasswordCount) characters")
        }
        
        return .ok(msg: "password acceptable")
    }
    
    func validateRepeatPassword(_ password: String, repeatPassword: String) -> ValidationResult {
        if repeatPassword.isEmpty {
            return .empty
        }
        
        if repeatPassword == password {
            return .ok(msg: "password repeated")
        } else {
            return .failed(msg: "password different")
        }
    }
    
}

class DefaultAPI: API {
    let URLSession: Foundation.URLSession
    
    static let shareAPI = DefaultAPI(urlSession: Foundation.URLSession.shared)
    
    init(urlSession: URLSession) {
        self.URLSession = urlSession
    }
    
    /// 这边到时候要去请求真正的接口获取相对应的东西，这边暂时只是返回一个true
    func usernameAvailable(username: String) -> Observable<Bool> {
        return Observable<Bool>.of(true)
    }
    
    func signup(username: String, password: String) -> Observable<Bool> {
        return Observable<Bool>.just(true).delay(.seconds(3), scheduler: MainScheduler.instance)
    }
    
}
