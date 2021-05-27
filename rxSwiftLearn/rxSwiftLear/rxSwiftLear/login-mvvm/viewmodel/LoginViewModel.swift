//
//  LoginViewModel.swift
//  RxSwiftDemo
//
//  Created by Yk Huang on 2021/5/11.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let validatedUsername: Observable<ValidationResult>
    let validatedPassword: Observable<ValidationResult>
    let validatedRepeatPassword: Observable<ValidationResult>
    
    let signupEnabled: Observable<Bool>
    let signedIn: Observable<Bool>
//    let signingIn: Observable<Bool>
    
    init(input: (username: Observable<String>,
                 password: Observable<String>,
                 repeatPassword: Observable<String>,
                 loginTaps: Observable<Void>),
         dependency: (validationService: ValidationService,
                      api: API,
                      wireframe: Wireframe)) {
        let api = dependency.api
        let validataionService = dependency.validationService
        let wireframe = dependency.wireframe
        
        validatedUsername = input.username.flatMapLatest { (username) -> Observable<ValidationResult> in
            print("校验username:\(username)")
//            let newScheduler = SerialDispatchQueueScheduler.init(qos: .background)
//                .observeOn(newScheduler)
            return validataionService.validateUsername(userName: username)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.failed(msg: "username 判断异常"))
        }
        // 这边使用了map，而上面使用了flatMapLatest是因为service.validatePassword和service.validateUsername的返回值不一样
        validatedPassword = input.password.map { (password) -> ValidationResult in
            print("校验password:\(password)")
            return validataionService.validatePassword(password: password)
        }.share(replay: 1, scope: .whileConnected)
        /**
         combineLatest：把password，repeatPassword，传给validataionService.validateRepeatPassword处理
         返回的结果作为结果
         */
        validatedRepeatPassword = Observable.combineLatest(input.password, input.repeatPassword, resultSelector: validataionService.validateRepeatPassword).share(replay: 1, scope: .whileConnected)
        let usernameAndPassword = Observable.combineLatest(input.username,
                                                           input.password,
                                                           resultSelector: {(username: $0, password: $1)})
        //withLatestFrom,返回observable的最后一个元素
  
        signedIn = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest({ (pair) -> Observable<Bool> in
                return api.signup(username: pair.username, password: pair.password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(false)
//                    .trackActivity(signingIn)
            })
            .flatMapLatest({ (loggedIn) -> Observable<Bool> in
                let msg = loggedIn ? "登陆成功" : "登陆失败"
                return wireframe.promptFor(msg, cancelAction: "OK", actions: [])
                    .map { _ in
                        loggedIn
                    }
            })
            .share(replay: 1)
        
        signupEnabled = Observable.combineLatest(validatedUsername,
                                                 validatedPassword,
                                                 validatedRepeatPassword
        ) { username, password, repeatPassword in
            username.isValid &&
            password.isValid &&
            repeatPassword.isValid
//                && !signingIn
        }
        .distinctUntilChanged()//distinctUntilChanged 操作符将阻止 Observable 发出相同的元素。如果后一个元素和前一个元素是相同的，那么这个元素将不会被发出来。如果后一个元素和前一个元素不相同，那么这个元素才会被发出来。
        .share(replay: 1)
    }
}
