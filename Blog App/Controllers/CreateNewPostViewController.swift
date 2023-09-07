//
//  CreateNewPostViewController.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import UIKit

class CreateNewPostViewController: UITabBarController {
    
    //Title to field
    private let titleField: UITextField = {
       let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.placeholder = "Enter Title...."
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .yes
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    // TextView for post
    private let textView: UITextView = {
       let textview = UITextView()
        textview.isEditable = true
        textview.backgroundColor = .secondarySystemBackground
        textview.font = .systemFont(ofSize: 28)
        return textview
    }()
    
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
