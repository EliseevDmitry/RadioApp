//
//  LanguageView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

struct LanguageView: View {
    // MARK: - Properties
    @AppStorage("selectedLanguage") private var language = LocalizationService.shared.language
    
    // MARK: - Body
    var body: some View {
        ZStack {
            DS.Colors.darkBlue
                .ignoresSafeArea()
            
            // MARK: Language List
            List(Language.allCases) { lang in
                LanguageElementView(
                    language: lang.rawValue.capitalized,
                    isSelected: language == lang
                )
                .onTapGesture {
                    self.language = lang
                }
                .listRowBackground(DS.Colors.darkBlue)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle(Resources.Text.language.capitalized.localized(language))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackBarButton()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    LanguageView()
}
