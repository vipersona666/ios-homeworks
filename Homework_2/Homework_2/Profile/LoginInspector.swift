//
//  LoginInspector.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 18.10.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate{
    func check(login: String, password: String) -> Bool {
        return Checker.checker.check(login: login, and: password)
    }
    
//    func check(checker: Checker) -> Bool {
//        <#code#>
//    }
    
//    func check(login: String, and password: String) -> Checker {
//        <#code#>
//    }
    
    //let vc = LogInViewController()
    //vc.loginDelegate = self
    //func check(login: String, and password: String) -> Checker
}
