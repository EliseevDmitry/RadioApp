//
//  CustomTabBarView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct CustomTabBarView: View {
    //MARK: - PROPERTIES
    var appManager: ViewModel
    @Binding var selectedTab: Tab
    //MARK: - BODY
    var body: some View {
        HStack {
            Button {
                selectedTab = .popular
                appManager.isActiveDetailView = false
            } label: {
                VStack {
                    Text(selectedTab == .popular ? "Popular" : "Popular")
                        .font(.custom(DS.Fonts.sfMedium, size: 19))
                        .foregroundColor(selectedTab == .popular ? Color.white : DS.Colors.grayNotActive)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(selectedTab == .popular ? DS.Colors.blueNeon : DS.Colors.darkBlue)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 3)
            Button {
                selectedTab = .favorites
                appManager.isActiveDetailView = false
            } label: {
                VStack {
                    Text(selectedTab == .favorites ? "Favorites" : "Favorites")
                        .font(.custom(DS.Fonts.sfMedium, size: 19))
                        .foregroundColor(selectedTab == .favorites ? Color.white : DS.Colors.grayNotActive)
                    
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(selectedTab == .favorites ? DS.Colors.blueNeon : DS.Colors.darkBlue)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 3)
            Button {
                selectedTab = .allStations
                appManager.isActiveDetailView = false
            } label: {
                VStack {
                    Text(selectedTab == .allStations ? "All Stations" : "All Stations")
                        .font(.custom(DS.Fonts.sfMedium, size: 19))
                        .foregroundColor(selectedTab == .allStations ? Color.white : DS.Colors.grayNotActive)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(selectedTab == .allStations ? DS.Colors.blueNeon : DS.Colors.darkBlue)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 3)
        }
        .overlay {
            HStack(spacing: 30) {
                BackButtonView(appManager: appManager)
                PlayButtonView(appManager: appManager)
                ForwardButtonView(appManager: appManager)
            }
            .offset(CGSize(width: 4, height: -120))
        }
        .frame(height: 80)
        .padding(.bottom, 3)
        .background(DS.Colors.darkBlue)
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView(appManager: ViewModel())
}
