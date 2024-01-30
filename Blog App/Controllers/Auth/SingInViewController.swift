//
//  SingInViewController.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import UIKit

class SingInViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            if !IAPManager.shared.isPremium(){
                let vc = PayWallViewController()
                self.present(vc, animated: true)
            }
        }
        
        
    }
}
