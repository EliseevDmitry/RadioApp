//
//  ContentView.swift
//  RadioApp
//
//  Created by Evgeniy K on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appManager: ViewModel
    @State var currentTab: Tab = .popular
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                TabView(selection: $currentTab) {
                    PopularView()
                        .environmentObject(appManager)
                        .onDisappear {
                            
                            appManager.stopAudioStream()
                        }
                        .tag(Tab.popular)
                    
                    FavoritesView()
                        .tag(Tab.favorites)
                    
                    AllStationsView()
                        .environmentObject(appManager)
                        .tag(Tab.allStations)
                }
                CustomTabBarView(currentTab: $currentTab)
            }
            .ignoresSafeArea(.keyboard)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ToolbarName()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    ToolbarProfile()
                }
            }
            .overlay {
                HStack(spacing: 30){
                    BackButtonView()
                    PlayButtonView()
                    ForwardButtonView()
                }
                .offset(CGSize(width: 4, height: 240))
            }
        }
        .navigationViewStyle(.stack)
        .dynamicTypeSize(.xSmall ... .xxLarge)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        ContentView()
            .environmentObject(previewAppManager)
    }
}
