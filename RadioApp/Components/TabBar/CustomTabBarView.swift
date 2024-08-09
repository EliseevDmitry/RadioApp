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
        VStack {
            HStack(spacing: 0.0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in

                    Button {
                        withAnimation(.easeInOut) {
                            currentTab = tab
                        }
                    } label: {
                        HStack {
                            VStack {
                                Text(tab.rawValue)
                                    .font(.custom(DS.Fonts.sfMedium, size: 20))
                                    .foregroundColor(currentTab == tab ? Color.white : DS.Colors.grayNotActive)

                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(currentTab == tab ? DS.Colors.blueNeon : DS.Colors.darkBlue)
                                    .clipShape(Circle())
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 30)
        }
        .frame(height: 38)
        .padding(.top, 12)
        .background(DS.Colors.darkBlue)
    }
}

#Preview {
    CustomTabBarView(currentTab: .constant(.popular))
}
