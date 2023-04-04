//
//  CheckerService.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 03.02.2023.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import Firebase
import UIKit


protocol CheckerServiceProtocol{
    func checkCredentials(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void)
    func signUp(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol{
    
    func checkCredentials(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil{
                if let result = authResult{
                    print("User UID:", result.user.uid)
                    let user = User(userName: "cat_pirat".localized, password: password, avatar: UIImage(named: "cat5")!, login: email, status: "advanced".localized)
                    completionBlock(.success(user))
                }
            }
            else{
                completionBlock(.failure(error!))
            }
        }
    }
    
    func signUp(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil{
                if let result = authResult{
                    print("User UID:", result.user.uid)
                    let user = User(userName: "cat_programmer".localized, password: password, avatar: UIImage(named: "cat2")!, login: email, status: "beginner".localized)
                    completionBlock(.success(user))
                }
            }
            else{
                completionBlock(.failure(error!))
            }
        }
    }
}
