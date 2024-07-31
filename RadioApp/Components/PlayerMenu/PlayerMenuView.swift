//
//  PlayerMenuView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct PlayerMenuView: View {
    var body: some View {
        HStack(spacing: 40){
            BackButtonView()
            PlayButtonView()
            ForwardButtonView()
        }
    }
}

#Preview {
    PlayerMenuView()
}
