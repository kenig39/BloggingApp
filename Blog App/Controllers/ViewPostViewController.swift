//
//  ViewPostViewController.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import UIKit

class ViewPostViewController: UITabBarController {

    private let post: BlogPost
    
    init(post:BlogPost){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    

}
