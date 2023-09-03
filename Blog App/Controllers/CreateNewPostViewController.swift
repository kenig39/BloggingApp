//
//  CreateNewPostViewController.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import UIKit

class CreateNewPostViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapCancel))
       
    }
    

}
