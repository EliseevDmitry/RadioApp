//
//  LocalizationService.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 02.08.2024.
//


import Foundation
import SwiftUI

// MARK: - Language Enum
enum Language: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case ru = "ru"
    case en = "en"
    case de = "de"
    case it = "it"
}

final class LocalizationService {
    // MARK: - Properties
    public static let shared = LocalizationService()
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "selectedLanguage") else {
                saveLanguage(.en)
                return .en
            }
            
            return Language(rawValue: languageString) ?? .en
        } set {
            if newValue != language {
                saveLanguage(newValue)
            }
        }
    }
    
    // MARK: - Init
    public init() { }
    
    // MARK: - Methods
    private func saveLanguage(_ language: Language) {
        UserDefaults.standard.setValue(language.rawValue, forKey: "selectedLanguage")
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
    }
}
