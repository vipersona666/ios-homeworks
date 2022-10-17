//
//  CurrentUserService.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 10.10.2022.
//

import UIKit

class CurrentUserService: UserService{
    
    let user: User?
    
    init(user: User){
        self.user = user
    }
    
    func entryLogin(login: String, password: String) -> User? {
        let user = User(userName: "Coder Cat", password: "1234", avatar: UIImage(named: "cat2")!, login: "admin", status: "Эксперт")
        if (user.login != login && user.password != password) {
            print("Неверный логин или пароль")
            return nil
        } else{
            print("Вход выполнен")
            return user
        }
    }
        
}
    
    
    

