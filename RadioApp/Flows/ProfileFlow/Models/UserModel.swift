//
//  UserModel.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 02.08.2024.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let userName: String
    let email: String
    var avatar: String?
}
