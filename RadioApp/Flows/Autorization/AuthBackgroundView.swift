//
//  AuthBackgroundView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 03.08.2024.
//

import SwiftUI

struct AuthBackgroundView: View {
    var body: some View {
        ZStack {
            Image("pinkSpots").resizable()
        }
        .ignoresSafeArea()
        .scaledToFill()
    }
}

#Preview {
    AuthBackgroundView()
}
