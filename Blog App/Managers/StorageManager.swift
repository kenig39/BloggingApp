
import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
        
    private let container = Storage.storage()
        
        private init(){}
    
    public func uploadUserProfilePicture(
        email: String,
        image: UIImage?,
        completion: @escaping(Bool) -> Void
    ){
        
    }
    
    public func updateProfilePicture(
        email: String,
        image: UIImage?,
        complition: @escaping(Bool) -> Void
    ){
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        
        guard let pngData = image?.pngData() else {
            return
        }
        
        container
            .reference(withPath: "profile_pictures/\(path)/photo.png")
            .putData(pngData, completion: { metadata , error in
                guard metadata != nil, error == nil else {
                    complition(false)
                    return
                }
                complition(true)
            })
    }
    
    public func uploadBloagHeaderImage(
        blogPost: BlogPost,
        image: UIImage?,
        complition: @escaping(Bool) -> Void
    ){
       
    }
    
    public func downloadUrlForProfilePicture(
        path: String,
        complition: @escaping (URL?) -> Void
    ){
        container.reference(withPath: path)
            .downloadURL(completion: { url, _ in
                complition(url)
            })
        
    }
        
    }

