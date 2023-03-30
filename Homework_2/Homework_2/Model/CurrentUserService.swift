//
//  CurrentUserService.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 10.10.2022.
//

import Foundation

class CurrentUserService: UserService{
    
    let user: User?
    
    init(user: User){
        self.user = user
    }
    
    func entryLogin(login: String, password: String) -> User? {
        if (user?.login != login && user?.password != password) {
            print("Неверный логин или пароль")
            return nil
        } else{
            print("Вход выполнен")
            return user
        }
    }
        
}
    
    
    

