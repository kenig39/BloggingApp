
import UIKit

class SingUpViewController: UITabBarController {

    //Header  view
    private let headerView = SignInHeaderView()
    
    //Name field
    private let nameTextField: UITextField = {
       let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.placeholder = "Full Name"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    
    
    //Email field
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.placeholder = "Email Address"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
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
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Account"
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
       
        
        signUpButton.addTarget(self, action: #selector(didTapSingUp), for: .touchUpInside)
        
        
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
        
        nameTextField.frame = CGRect(x: 20, y: headerView.bottom, width: view.with-40, height: 50)
        emailTextField.frame = CGRect(x: 20, y: nameTextField.bottom+10, width: view.with-40, height: 50)
        passwordTextField.frame = CGRect(x: 20, y: emailTextField.bottom+10, width: view.with-40, height: 50)
        signUpButton.frame = CGRect(x: 20, y: passwordTextField.bottom+10, width: view.with-40, height: 50)
     
    }
   
    @objc func didTapSingUp(){
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = nameTextField.text, !name.isEmpty else {
            return
        }
        //Create User
        AuthManager.shared.signUp(email: email, password: password, complition: { [weak self] succes in
            if succes {
                let newUser = User(name: name, email: email, profilePictureRef: nil)
                DatabaseManager.shared.insert(user: newUser, complition: { inserted in
                    guard inserted else {
                        return
                    }
                    
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(name, forKey: "name")
                    DispatchQueue.main.async {
                        let vc = TabBarViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated:  true)
                    }
                })
            } else {
                print("Failed to account")
            }
        })
    }
    
   
}
