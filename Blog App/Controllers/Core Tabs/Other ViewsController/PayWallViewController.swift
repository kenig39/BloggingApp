//
//  payWallViewController.swift
//  Blog App
//
//  Created by Alexander on 30.01.2024.
//

import UIKit


class PayWallViewController: UIViewController {
    
    private let header = PayWallHeaderView()
    
    private let descriptionPurchase = PayWallDescriptionView()
    
    //CTA Buttons
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restore Purhases", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    //Terms of service must have on your app
    private let termsView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = .secondaryLabel
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 14)
        textView.text = "This is an auto-renewable subscription. It will be charged to your iTunes account before each pay period. You can cancel anytime by goin into your Setting > Subscription. Restore purchases if previously subscribed"
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Thought Premium"
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        view.addSubview(buyButton)
        view.addSubview(restoreButton)
        view.addSubview(termsView)
        view.addSubview(descriptionPurchase)
        setUpCloseButton()
        setUpButtons()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame = CGRect(x: 0,
                              y:  view.safeAreaInsets.top,
                              width: view.with,
                              height: view.height/3.2)
        
        termsView.frame = CGRect(x: 10,
                                 y:  view.height - 100,
                                 width: view.with - 20,
                                 height: 100)
        restoreButton.frame = CGRect(x: 25,
                                     y: termsView.top - 70,
                                     width: view.with - 50,
                                     height: 50)
        buyButton.frame = CGRect(x: 25,
                                 y:  restoreButton.top - 60,
                                 width: view.with - 50,
                                 height: 50)
        descriptionPurchase.frame = CGRect(x: 0,
                                           y: header.bottom,
                                           width: view.with,
                                           height: buyButton.top - view.safeAreaInsets.top - header.height)
    }
    
    private func setUpButtons(){
        buyButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }
    
    @objc private func didTapSubscribe(){
        
    }
    
    @objc private func didTapRestore(){
        
    }

        
    // Close Button / title
    private func setUpCloseButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self,action: #selector(didTapClose))
    }
    
    @objc func didTapClose(){
       dismiss(animated: true)
    }
    
    }
