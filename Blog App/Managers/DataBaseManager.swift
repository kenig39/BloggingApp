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
        user: User,
        complition: @escaping(Bool) -> Void
    ){
        
    }
    
     public func getAllPosts(
        complition: @escaping([BlogPost]) -> Void
       ){
     }
    
    public func getPosts(
      for user: User,
       complition: @escaping([BlogPost]) -> Void
      ){
    }
    public func insert(
       user: User,
       complition: @escaping(Bool) -> Void
      ){
          let documentId = user.email
              .replacingOccurrences(of: ".", with: ".")
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
}
