//
//  ContentView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import Kingfisher
import SwiftUI

struct WelcomeView: View {
    @State private var val:CGFloat = 0.5
    var body: some View {
        VStack {
            Text("Let's Get Started")
                .font(.custom(.sfSemibold, size: 49))
            VolumeView(voulmeValue: $val)
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
