//
//  LanguageElementView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 04.08.2024.
//

import SwiftUI

// MARK: - LanguageElementView
struct LanguageElementView: View {
    
    // MARK: - Properties
    var language: String
    var isSelected: Bool
    
    // MARK: - Constants
    private struct Constants {
        static let cornerRadius: CGFloat = 20.0
        static let fontSize: CGFloat = 40.0
        static let padding: CGFloat = 16.0
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(isSelected ? DS.Colors.pinkNeon : DS.Colors.turquoise)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                .padding(Constants.padding)
            HStack {
                Text(language)
                    .foregroundStyle(.white)
                    .font(.custom(DS.Fonts.sfBold, size: Constants.fontSize))
                    .padding()
            }
        }
    }
}


// MARK: - Preview
#Preview {
    LanguageElementView(language: "English", isSelected: true)
}
