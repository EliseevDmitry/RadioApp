//
//  AuthDataResultModel.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 08.08.2024.
//

import Foundation
import FirebaseAuth

// модель, в соответствии с которой структурируются данные о пользователе в результате прохождения аутентификации пользователя
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let displayName: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.displayName = user.displayName
        self.photoUrl = user.photoURL?.absoluteString
    }
}
