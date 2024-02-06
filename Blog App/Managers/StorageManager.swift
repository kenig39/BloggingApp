
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
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        
        guard let pngData = image?.pngData() else {
            return }
        container
            .reference(withPath: "profile_pictures/\(path)/photo.png")
            .putData(pngData, completion: { metadata , error in
                guard metadata != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
    }
    
    public func downloadUrlForProfilePicture(
        user: String,
        complition: @escaping(Bool) -> Void
    ){
        
        
    }
    
    public func uploadBloagHeaderImage(
        email: String,
        image: UIImage,
        postid: String,
        completion: @escaping(Bool) -> Void
    ){
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        
        guard let pngData = image.pngData() else {
            return }
        
        container
            .reference(withPath: "post_headers/\(path)/\(postid).png")
            .putData(pngData, completion: { metadata , error in
                guard metadata != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
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
    
    public func downloadUrlForPostHeder(
        email: String,
        postId: String,
        completion: @escaping(URL?) ->Void
    ){
        
        let emailComponent = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        
        container
            .reference(withPath: "post_headers/\(emailComponent)/\(postId).png")
            .downloadURL(completion: { url, _ in
                completion(url)
                
            })
    }
    
}
