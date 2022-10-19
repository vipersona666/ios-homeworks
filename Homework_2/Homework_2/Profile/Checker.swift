//
//  Checker.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 17.10.2022.
//

import UIKit

class Checker{
    static let checker = Checker()
    private init() {}
    
#if DEBUG
    private let login = "pirat"
    private let password = "1234"
#else
    private let login = "karate"
    private let password = "12345"
#endif
    
    func check(login: String, and password: String) -> Bool{
        if self.login == login && self.password == password{
            return true
        } else {
            return false
        }
    }
}
