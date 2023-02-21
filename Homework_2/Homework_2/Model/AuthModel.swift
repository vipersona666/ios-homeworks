//
//  AuthModel.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 20.02.2023.
//

import Foundation
import RealmSwift

class AuthUser: Object{
    @Persisted var login: String
    @Persisted var password: String
    @Persisted (primaryKey: true) var id: ObjectId
}
