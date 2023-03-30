//
//  LoginInspector.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 19.10.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate{
    func check(login: String, password: String) -> Bool {
        return Checker.checker.check(login: login, and: password)
    }

}
