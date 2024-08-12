//
//  WelcomeBackgroundView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 03.08.2024.
//

import SwiftUI

struct WelcomeBackgroundView: View {
    //MARK: - BODY
    var body: some View {
        ZStack {
            Image("blueGradient").resizable()
            Image("pinkGradient").resizable()
            Image("djWoman").resizable()
            Image("pinkSpots").resizable()
        }
        .ignoresSafeArea()
        .opacity(0.8)
        .scaledToFill()
    }
}

//MARK: - PREVIEW
#Preview {
    WelcomeBackgroundView()
}
