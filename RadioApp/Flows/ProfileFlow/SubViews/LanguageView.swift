//
//  LanguageView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

struct LanguageView: View {
    
    // MARK: - Properties
    @State private var selectedLanguage: Language? = nil
    
    // MARK: - Body
    var body: some View {
        ZStack {
            DS.Colors.darkBlue
                .ignoresSafeArea()
            
            // MARK: Language List
            List(Language.allCases) { language in
                LanguageElementView(
                    language: language.rawValue.capitalized,
                    isSelected: selectedLanguage == language
                )
                .onTapGesture {
                    selectedLanguage = language
                }
                .listRowBackground(DS.Colors.darkBlue)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle(Resources.Text.language.capitalized)
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
