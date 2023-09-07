//
//  CreateNewPostViewController.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import UIKit

class CreateNewPostViewController: UITabBarController {
    
    //Titlr to field
    
    
    //Image Header
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureButton()
    }
    
    
    private  func configureButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapPost))
        
    }
    
    @objc func didTapCancel(){
        
    }
    
    @objc func didTapPost(){
        
    }
        
}
