//
//  LoginViewControllerDelegate.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 18.10.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool
}

extension LoginViewControllerDelegate{
    
    func check(login: String, password: String) -> Bool {
         Checker.checker.check(login: login, and: password)
    }
}
