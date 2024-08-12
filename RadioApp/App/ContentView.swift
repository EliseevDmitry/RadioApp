//
//  ContentView.swift
//  RadioApp
//
//  Created by Evgeniy K on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appManager: ViewModel
    @State var selectedTab: Tab = .popular
    @State var showTabBar: Bool = true
    @State var tapBarVisible = true
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                switch selectedTab {
                case .popular:
                    PopularView(appManager: appManager)
                case .favorites:
                    FavoritesView(appManager: appManager)
                        
                case .allStations:
                    AllStationsView(appManager: appManager)
                }
                CustomTabBarView(appManager: appManager, selectedTab: $selectedTab)
                Spacer()
            }
            //.navigationViewStyle(.stack)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .dynamicTypeSize(.xSmall ... .xLarge)
        }
    }
}

#Preview {
    ContentView(appManager: ViewModel())
}
