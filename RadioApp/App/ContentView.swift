//
//  ContentView.swift
//  RadioApp
//
//  Created by Evgeniy K on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appManager: ViewModel
    @State var selectedTab: Tab = .popular
    @State var showTabBar: Bool = true
    @State var tapBarVisible = true
    
    
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Spacer()
                
                switch selectedTab {
                case .popular:
                    PopularView()
                case .favorites:
                    FavoritesView()
                case .allStations:
                    AllStationsView()
                }
                
                CustomTabBarView(selectedTab: $selectedTab)
                Spacer()
                
            }
            .navigationViewStyle(.stack)
            .ignoresSafeArea()
            .dynamicTypeSize(.xSmall ... .xLarge)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                        ToolbarName()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ToolbarProfile()
                }
            }
            .background(DS.Colors.darkBlue)
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
