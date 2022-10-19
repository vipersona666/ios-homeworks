//
//  TestUserService.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 17.10.2022.
//

import UIKit

class TestUserService: UserService {
    
    let user: User?

       init(user: User){
           self.user = user
       }
    
     //let testUser = User(userName: "Test Cat", password: "123", avatar: UIImage(named: "cat4")!, login: "user", status: "Test")
    
    func entryLogin(login: String, password: String) -> User? {
       
        if (user!.login != login && user!.password != password) {
            print("Неверный логин или пароль")
            return nil
        } else{
            print("Вход выполнен")
            return user
        }
    }
    

   

}
