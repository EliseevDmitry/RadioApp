//
//  LanguageView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

struct LanguageView: View {
    var body: some View {
        ZStack {
            DS.Colors.darkBlue
                .ignoresSafeArea()
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

#Preview {
    LanguageView()
}
