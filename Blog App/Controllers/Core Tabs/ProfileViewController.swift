

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sigh Out", style: .done, target: self, action: #selector(didTapSignOut))
    }
    
    @objc private func  didTapSignOut(){
        
    }
    

  

}
