

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
        fetchPosts()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableHeader()
        fetchProfileData()
    }
    
  
    
    private func setUpTableHeader
    (profilePhotoRef: String? = nil,
    name: String? = nil) {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.with, height: view.with/1.5))
        headerView.backgroundColor = .systemBlue
        headerView.isUserInteractionEnabled = true
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
        
        profilePhoto.isUserInteractionEnabled = true
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.with/2
        headerView.addSubview(profilePhoto)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePhoto))
        profilePhoto.addGestureRecognizer(tap)
        
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
            print("found photo select \(ref)")
            
            StorageManager.shared.downloadUrlForProfilePicture(path: ref) { url in
                guard let url = url else {
                    return
                }
                let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        profilePhoto.image = UIImage(data: data)
                    }
                })
                   
                task.resume()
                }
               
            }
            
        }
        
    
    
    @objc private func didTapProfilePhoto(){
        guard let myEmail = UserDefaults.standard.string(forKey: "email"),
        myEmail == currentEmail else {
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func fetchProfileData(){
        DatabaseManager.shared.getUser(email: currentEmail, complition: { [weak self] user in
            guard let user = user else {
                return
            }
            self?.user = user
            
            DispatchQueue.main.async {
                self?.setUpTableHeader(profilePhotoRef:
                                        user.profilePictureRef,
                                       name: user.name)
            }
            
        })
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
    
    private var posts: [BlogPost] = []
    
    private func fetchPosts(){
        guard let email = user?.email else {
            return
        }
        DatabaseManager.shared.getPosts(for: email, complition: { [weak self] posts in
            self?.posts = posts
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewPostViewController()
        vc.title = posts[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        StorageManager.shared.uploadUserProfilePicture(email: currentEmail,
                                                       image: image,
                                                       completion: { [weak self] success in
            guard let strongSelf = self else {return}
            if success {
                //Update dataBase
                DatabaseManager.shared.upDateProfileManager(email: strongSelf.currentEmail, completion: { updated in
                    guard updated else {
                        return
                    }
                    DispatchQueue.main.async {
                        strongSelf.fetchProfileData()
                    }
                })
            }
        })
    }
}
