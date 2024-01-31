

import UIKit

class PayWallDescriptionView: UIView {

    private let descriptionlabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.numberOfLines = 0
        label.text = "Join Blogs premium to read unlimited articles and browse thousand of posts."
        return label
    }()
    
    private let priceLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 1
        label.text = " 0.99 / month "
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(priceLabel)
        addSubview(descriptionlabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        descriptionlabel.frame = CGRect(x: 20,
                                        y: 0,
                                        width: with - 40,
                                        height: height / 2)
       priceLabel.frame = CGRect(x: 20,
                                        y: height / 2,
                                        width: with - 40,
                                        height: height / 2)
    }
}
