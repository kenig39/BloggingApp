

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    private var user: User?
    
    private let tableView: UITableView = {
          let tableView = UITableView()
          tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         return tableView
      }()
      
    
    let currentEmail: String
    
    init(currentEmail: String) {
        self.currentEmail = currentEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSignOutButton()
        setUpTableView()
        title = "Profile"
      
    }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableHeader()
        fetchProfileData()
    }
    
  
    
    private func setUpTableHeader(profilePhotoRef: String? = nil, name: String? = nil){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.with, height: view.with/1.5))
        headerView.backgroundColor = .systemBlue
        tableView.tableHeaderView = headerView
        headerView.clipsToBounds = true
        
        //Profile Picture
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle"))
        profilePhoto.tintColor = .white
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.frame = CGRect(x: (view.with-(view.with/4))/2,
                                    y: (headerView.height-(view.with/4))/3,
                                    width: view.with/4,
                                    height: view.with/4)
        
        headerView.addSubview(profilePhoto)
        
        //Email
        
        let emailLabel = UILabel(frame: CGRect(x: 20,
                                               y: profilePhoto.bottom+15,
                                               width: view.with-40,
                                               height: 100))
        headerView.addSubview(emailLabel)
        emailLabel.text = currentEmail
        emailLabel.textAlignment = .center
        emailLabel.textColor = .white
        emailLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        if let name = name {
            title = name
        }
        if let ref = profilePhotoRef {
            
        }
        
    }
    
    
    private func fetchProfileData(){
        DatabaseManager.shared.getUser(email: currentEmail, complition: { [weak self] user in
            guard let user = user else {
                return
            }
            self?.user = user
            
            DispatchQueue.main.async {
                self?.setUpTableHeader(profilePhotoRef: user.profilePictureRef,
                                       name: user.name)
            }
            
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    private func setUpSignOutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sigh Out",
                                                            style: .done,
                                                            target: self, action: #selector(didTapSignOut))
    }
    
    
    
    // Sing Out
    @objc private func  didTapSignOut(){
        let sheet = UIAlertController(title: "Sign Out", message: "Are you shure to go away", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut(complition: {[weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        
                        let signInVc = SingInViewController()
                        signInVc.navigationItem.largeTitleDisplayMode = .always
                        
                        let navVC = UINavigationController(rootViewController: signInVc)
                        navVC.navigationBar.prefersLargeTitles = true
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true)
                    }
                }
            })
        }))
        present(sheet, animated: true)
    }
    
    //TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Blog post goes"
        
        return cell
    }
  

}
