//
//  PostPreviewTableViewTableViewCell.swift
//  Blog App
//
//  Created by Alexander on 07.02.2024.
//

import UIKit

class PostPreviewTableViewTableViewCell: UITableViewCell {

    static let indentifire = "PostPreviewTableViewCell"
    
    private let postImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let postTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
        contentView.addSubview(postTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = CGRect(x: separatorInset.left,
                                     y: 5,
                                     width: contentView.height-10,
                                     height: contentView.height-10)
        
        postTitleLabel.frame = CGRect(x: postImageView.right+5,
                                      y: 5,
                                      width: contentView.with-5-separatorInset.left-postImageView.with,
                                      height: contentView.height-10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView .image = nil
        postTitleLabel.text = nil
    }
    
    func configure(with string: String){
        
    }
}
