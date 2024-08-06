//
//  String + Extension.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 06.08.2024.
//

import Foundation

extension String {
    func localized(_ language: Language) -> String {
        // Получаем путь к Bundle для выбранного языка
        guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            print("Failed to find path for language: \(language.rawValue)")
            return self
        }
        
        // Получаем строку из NSLocalizedString
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
