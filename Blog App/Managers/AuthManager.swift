
import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init(){}
    
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
        
    }
    
    public func signUp(
        email: String,
        password: String,
        complition: @escaping(Bool) -> Void
    ){
              guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty,
                        password.count >= 6 else {
            return
        }
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                complition(false)
                return
            }
            // Account Created
            complition(true)
            
        }
    }
    
    public func signIn(
        email: String,
        password: String,
        complition: @escaping(Bool) -> Void ){
            guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
                      password.count >= 6 else {
          return
      }
            
            auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    complition(false)
                    return
                }
            
                complition(true)
            }
    }
    
    public func signOut(
        complition: (Bool) -> Void ){
            do {
                try auth.signOut()
                complition(true)
            } catch {
                print(error)
                complition(false)
        }
    }
}

