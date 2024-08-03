//
//  ContentView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import Kingfisher
import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appManager: ViewModel
    var body: some View {
        VStack {
            Text("Let's Get Started")
                .font(.custom(.sfSemibold, size: 49))

            VolumeView()
 
        }
        .padding()
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()

    static var previews: some View {
        WelcomeView()
            .environmentObject(previewAppManager)
    }
}
