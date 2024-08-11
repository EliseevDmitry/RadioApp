//
//  AuthBackgroundView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 03.08.2024.
//

import SwiftUI

struct AuthBackgroundView: View {
    var body: some View {
        ZStack(alignment: .trailing) {
            Image("pinkSpots2").resizable().opacity(0.8)
            Image("Polygon 4")
                .offset(y: -UIScreen.height * 1/8)
        }
        .ignoresSafeArea()
        .scaledToFill()        
    }
}

#Preview {
    AuthBackgroundView()
}
