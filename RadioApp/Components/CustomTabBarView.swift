//
//  CustomTabBarView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct CustomTabBarView: View {

    @Binding var currentTab: Tab

    var body: some View {
        HStack(spacing: 0.0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Image(tab.rawValue)

            }
        }
        .frame(maxWidth: .infinity)
        .background(DS.Colors.turquoise)
    }
}

#Preview {
    //CustomTabBarView(currentTab: .constant(.popular))
    ContentView()
}
