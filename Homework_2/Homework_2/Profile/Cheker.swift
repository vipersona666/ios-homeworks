//
//  Cheker.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 19.10.2022.
//

import UIKit

class Checker{
    static let checker = Checker()
    private init() {}

#if DEBUG
    private let login = ""
    private let password = ""
#else
    //временно убираем пароль и логин
    private let login = "1"
    private let password = "1"
#endif

    func check(login: String, and password: String) -> Bool{
        self.login == login && self.password == password
    }
}
