
import UIKit

class PostHeaderTableViewCell: UITableViewCell {

    static let indentifire = "PostHeaderTableViewCell"
    
    private let postImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView .image = nil
    }
    
    func configure(with viewModel: PostPreviewTableViewCellViewModel){
       
        
        if let data = viewModel.imageData{
            postImageView.image = UIImage(data: data)
            
        }
        else if let url = viewModel.imageUrl {
            //fetch image & cache
            
            let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, _ in
                guard let data = data else {
                    return
                }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.postImageView.image = UIImage(data: data)
                }
                
            }
            
            task.resume()
        }
        
    }

}
