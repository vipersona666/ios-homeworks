//
//  LoginFactory.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 19.10.2022.
//

import Foundation
protocol LoginFactory{
    func makeLoginInspector() -> LoginInspector
}
struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
