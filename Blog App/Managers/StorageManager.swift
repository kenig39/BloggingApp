
import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
        
    private let container = Storage.storage().reference()
        
        private init(){}
    
    public func uploadUserProfilePicture(
        email: String,
        image: UIImage?,
        completion: @escaping(Bool) -> Void
    ){
        
    }
    
    public func downLoadUrlForProfilePicture(
        user: User,
        complition: @escaping(URL?) -> Void
    ){
        
    }
    
    public func uploadBloagHeaderImage(
        blogPost: BlogPost,
        image: UIImage?,
        complition: @escaping(Bool) -> Void
    ){
        
    }
    
    public func downloadUrlPostHeader(
        blogPost: BlogPost,
        complition: @escaping (URL?) -> Void
    ){
        
    }
        
    }

