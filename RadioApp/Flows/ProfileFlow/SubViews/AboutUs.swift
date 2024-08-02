//
//  AboutUs.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
        ZStack {
            DS.Colors.darkBlue
                .ignoresSafeArea()
        }
        .navigationTitle(Resources.Text.aboutUs.capitalized)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackBarButton()
            }
        }
    }
}

#Preview {
    AboutUs()
}
