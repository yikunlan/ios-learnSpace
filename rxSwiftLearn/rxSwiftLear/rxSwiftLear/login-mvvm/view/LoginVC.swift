//
//  LoginVC.swift
//  RxSwiftDemoUIViewController
//
//  Created by Yk Huang on 2021/5/11.
//  使用mvvm模式的登陆注册界面

import UIKit
import Foundation
import SnapKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var userNameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "userName"
        return tf
    }()
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        return tf
    }()
    lazy var repeatedPasswordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "repeatedPassword"
        return tf
    }()
    
    lazy var userNameValidLabel: UILabel = {
        let l = UILabel()
        l.text = "userName validation"
        l.textColor = UIColor.red
        return l
    }()
    
    lazy var passwordValidLabel: UILabel = {
        let l = UILabel()
        l.text = "password validation"
        l.textColor = UIColor.red
        return l
    }()
    
    lazy var repeatPasswordValidLabel: UILabel = {
        let l = UILabel()
        l.text = "repeatPassword validation"
        l.textColor = UIColor.green
        return l
    }()
    
    lazy var submitBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("submit", for: .normal)
        return btn
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.style = .medium
        return aiv
    }()
    
    lazy var viewModel: LoginViewModel = LoginViewModel(
        input: (userNameTF.rx.text.orEmpty.asObservable(),
                passwordTF.rx.text.orEmpty.asObservable(),
                repeatedPasswordTF.rx.text.orEmpty.asObservable(),
                loginTaps: submitBtn.rx.tap.asObservable()),
        dependency: (validationService: DefaultValidationService.sharedValidationService,
                     api: DefaultAPI.shareAPI, wireframe: DefaultWireframe.shared))
}

extension LoginVC {
    override func viewDidLoad() {
        title = "注册（使用mvvm模式）"
        view.backgroundColor = UIColor.white
        makeUI()
        bindModel()
    }
    
    func makeUI() {
        view.addSubview(userNameTF)
        view.addSubview(passwordTF)
        view.addSubview(repeatedPasswordTF)
        view.addSubview(userNameValidLabel)
        view.addSubview(passwordValidLabel)
        view.addSubview(repeatPasswordValidLabel)
        view.addSubview(submitBtn)
        view.addSubview(loadingView)
        
        userNameTF.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.width.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        userNameValidLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.top.equalTo(userNameTF.snp.bottom).offset(10)
        }
        passwordTF.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.top.equalTo(userNameValidLabel.snp.bottom).offset(10)
        }
        passwordValidLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.top.equalTo(passwordTF.snp.bottom).offset(10)
        }
        repeatedPasswordTF.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(10)
        }
        repeatPasswordValidLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.top.equalTo(repeatedPasswordTF.snp.bottom).offset(10)
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(40)
            make.centerX.equalTo(self.view)
            make.height.equalTo(40)
            make.top.equalTo(repeatPasswordValidLabel.snp.bottom).offset(10)
        }
        
        loadingView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(submitBtn.snp.left).offset(5)
            make.top.equalTo(submitBtn.snp.top).offset(5)
        }
    }

    func bindModel() {
        viewModel.signupEnabled.subscribe(onNext: { [weak self] validate in
            self?.submitBtn.isEnabled = validate
            self?.submitBtn.alpha = validate ? 1.0 : 0.5
        }).disposed(by: disposeBag)
        
        viewModel.validatedUsername.bind(to: userNameValidLabel.rx.validationResult).disposed(by: disposeBag)
        
//        viewModel.validatedPassword.bind(to: passwordValidLabel.rx.validationResult).disposed(by: disposeBag)
        //等价于上面的那个
        let observer: Binder<ValidationResult> = Binder(passwordValidLabel) { [weak self] (label, result) in
            self?.passwordValidLabel.text = result.description
            self?.passwordValidLabel.textColor = result.textColor
        }
        viewModel.validatedPassword.bind(to: observer).disposed(by: disposeBag)
        
        
        viewModel.validatedRepeatPassword.bind(to: repeatPasswordValidLabel.rx.validationResult).disposed(by: disposeBag)
        viewModel.signedIn.subscribe(onNext: { signedIn in
            print("user signed in \(signedIn)")
        }).disposed(by: disposeBag)
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event.subscribe(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }
}
