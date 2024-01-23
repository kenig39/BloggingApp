//
//  PostPreviewTableViewTableViewCell.swift
//  Blog App
//
//  Created by Alexander on 07.02.2024.
//

import UIKit

class PostPreviewTableViewTableViewCell: UITableViewCell {

    static let indentifire = "PostPreviewTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with string: String){
        
    }
}
