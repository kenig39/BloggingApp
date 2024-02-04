//
//  CreateNewPostViewController.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import UIKit

class CreateNewPostViewController: UITabBarController {
    
    private var selectedHeaderImage: UIImage?
    
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
        view.addSubview(headerImageView)
        view.addSubview(textView)
        view.addSubview(titleField)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didTapHeader))
        headerImageView.addGestureRecognizer(tap)
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleField.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.with-20, height: 50)
        
        headerImageView.frame = CGRect(x: 0, y: titleField.bottom+5, width: view.with, height: 160)
        textView.frame = CGRect(x: 10, y: headerImageView.bottom+10, width: view.with-20, height: view.height-210-view.safeAreaInsets.top)
    }
    
    @objc private func didTapHeader(){
        let picked = UIImagePickerController()
        picked.sourceType = .photoLibrary
        picked.delegate = self
        present(picked, animated: true)
    }
    
    private  func configureButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapPost))
        
    }
    
    @objc func didTapCancel(){
        dismiss(animated: true)
    }
    
    @objc func didTapPost(){
        guard let title = titleField.text,
              let body = textView.text,
              let headerImage = selectedHeaderImage,
              let email = UserDefaults.standard.string(forKey: "email"),
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty
              
        else {
            return
        }
        let newPostId = UUID().uuidString
        
        //upload header Image
        StorageManager.shared.uploadBloagHeaderImage(email: email,
                                                     image: headerImage,
                                                     postid: newPostId,
                                                     completion: { success in
            guard success else {
                return
            }
            StorageManager.shared.downloadUrlForPostHeder(email: email,
                                                          postId: newPostId,
                                                          completion: { url in
                guard let headerUrl = url else {
                    return
                }
                //insert of post into DB
                let post = BlogPost(indentifier: newPostId,
                                    title: title,
                                    timestamp: Date().timeIntervalSince1970,
                                    headerImageUrl: nil,
                                    text: body)
                
            })
            
        })
        
       
    }
        
}
extension CreateNewPostViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
 
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
     
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        selectedHeaderImage = image
        headerImageView.image = image
    }
}
