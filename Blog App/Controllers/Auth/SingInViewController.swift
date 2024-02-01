//
//  SingInViewController.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import UIKit

class SingInViewController: UITabBarController {
    
    //Header  view
    private let headerView = SignInHeaderView()
    
    //Email field
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.placeholder = "Email Address"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    //Password field
    private let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    //Sign In Button
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //Create account
    private let creaetAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign In"
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(creaetAccountButton)
        
        signInButton.addTarget(self, action: #selector(didTapSingIn), for: .touchUpInside)
        creaetAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+3){
//            if !IAPManager.shared.isPremium(){
//                let vc = PayWallViewController()
//                let navVC = UINavigationController(rootViewController: vc)
//                self.present(navVC, animated: true)
//            }
        }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.with, height: view.height/4)
        
        emailTextField.frame = CGRect(x: 20, y: headerView.bottom, width: view.with-40, height: 50)
        passwordTextField.frame = CGRect(x: 20, y: emailTextField.bottom+10, width: view.with-40, height: 50)
        signInButton.frame = CGRect(x: 20, y: passwordTextField.bottom+10, width: view.with-40, height: 50)
        creaetAccountButton.frame = CGRect(x: 20, y: signInButton.bottom+30, width: view.with-40, height: 50)
    }
    
    @objc func didTapSingIn(){
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else{
            return
        }
        
        
        AuthManager.shared.signIn(email: email, password: password, complition: {[weak self] success in
            guard success else {
                return
            }
            
            DispatchQueue.main.async {
                UserDefaults.standard.set(email, forKey: "email")
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated:  true)
            }
        })
    }
    
    @objc func didTapCreateAccount(){
        let vc = SingUpViewController()
        vc.title = "Create Account"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
