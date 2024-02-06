//
//  DataBaseManager.swift
//  Blog App
//
//  Created by Alexander on 29.01.2024.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    private init(){}
    
    public func insert(
    blogPost: BlogPost,
    email: String,
        complition: @escaping(Bool) -> Void
    ){
        let userEmail = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data: [String: Any] = [
            "id": blogPost.indentifier,
            "title": blogPost.indentifier,
            "body": blogPost.text,
            "created": blogPost.timestamp,
            "header": blogPost.headerImageUrl?.absoluteString ?? ""
          
        ]
        database
            .collection("user")
            .document(userEmail)
            .collection("post")
            .document(blogPost.indentifier)
            .setData(data) { error in
                complition(error == nil)
                }
           
            }
    
     public func getAllPosts(
        complition: @escaping([BlogPost]) -> Void
       ){
     }
    
    public func getPosts(
      for email: String,
       complition: @escaping([BlogPost]) -> Void
      ){
          let userEmail = email
              .replacingOccurrences(of: ".", with: "_")
              .replacingOccurrences(of: "@", with: "_")
          
          database
              .collection("users")
              .document(userEmail)
              .collection("posts")
              .getDocuments(completion: { snapshot, error in
                  guard let documents = snapshot?.documents.compactMap{$0.data()}, error == nil else {
                      return
                  }
                  
                  let posts: [BlogPost] = documents.compactMap({dictionary in
                      guard let id = dictionary["id"] as? String,
                            let title = dictionary["title"],
                            
                      
                      let post = BlogPost(indentifier: <#T##String#>,
                                          title: <#T##String#>,
                                          timestamp: <#T##TimeInterval#>,
                                          headerImageUrl: <#T##URL?#>,
                                          text: <#T##String#>)
                  })
              })
    }
    
    
    
    public func insert(
       user: User,
       complition: @escaping(Bool) -> Void
      ){
          let documentId = user.email
              .replacingOccurrences(of: ".", with: "_")
              .replacingOccurrences(of: "@", with: "_")
          
          let data = [
            "email": user.email,
            "name": user.name
          ]
          database
              .collection("users")
              .document(documentId)
              .setData(data) { error in
                  complition(error == nil)
                  
              }
    }
    
    public func getUser(email: String, complition: @escaping(User?)-> Void){
        let documentId = email
            .replacingOccurrences(of: ".", with: ".")
            .replacingOccurrences(of: "@", with: "_")
        
        database
            .collection("users")
            .document(documentId)
            .getDocument(completion: { snapShot, error  in
                guard let data = snapShot?.data() as? [String:String],
                      let name = data["name"],
                      error == nil else {
                    return
                }
                
                let ref = data["profile_photo"]
                let user = User(name: name, email: email, profilePictureRef: ref)
                complition(user)
            })
    }
    
    func upDateProfileManager(
        email: String,
    completion: @escaping(Bool) -> Void) {
        
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        
        let photoReference = "profile_pictures/\(path)/photo.png"
        
        let dbRef = database
            .collection("users")
            .document(path)
            
        
        dbRef.getDocument(completion: { snapShot, error in
            guard var data = snapShot?.data(), error == nil else {
                return
            }
            data["Profile_photo"] = photoReference
            
            dbRef.setData(data){ error in
                    completion(error == nil)
            }
        })
    }
}
