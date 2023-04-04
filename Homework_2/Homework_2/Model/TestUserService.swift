//
//  TestUserService.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 17.10.2022.
//

import Foundation

class TestUserService: UserService {
    
    let user: User?

       init(user: User){
           self.user = user
       }

    func entryLogin(login: String, password: String) -> User? {
       
        if (user?.login != login && user?.password != password) {
            print("login_error".localized)
            return nil
        } else{
            print("auto_login".localized)
            return user
        }
    }
    

   

}
