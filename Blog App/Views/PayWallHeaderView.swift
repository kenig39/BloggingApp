//
//  PayWallHeaderView.swift
//  Blog App
//
//  Created by Alexander on 31.01.2024.
//

import UIKit

class PayWallHeaderView: UIView {
    
    //Header Image
    
    private let headerImageView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(systemName: "crown.fill"))
        imageView.frame = CGRect(x: 0, y: 0, width: 110, height: 110)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(headerImageView)
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = CGRect(x:(bounds.width - 110)/2 , y: (bounds.height - 110)/2, width: 110, height: 110)
    }
    
    
    
    
}
