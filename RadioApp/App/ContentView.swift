//
//  ContentView.swift
//  RadioApp
//
//  Created by Evgeniy K on 31.07.2024.
//

import SwiftUI

struct ContentView: View {

    @StateObject var appManager = ViewModel()
    @State var selectedTab: Tab = .popular
    @State var showTabBar: Bool = true

    var body: some View {
            VStack {
                Spacer()

                switch selectedTab {
                case .popular:
                    PopularView()
                        .environmentObject(appManager)
                case .favorites:
                    FavoritesView()
                        .environmentObject(appManager)
                        .environment(\.managedObjectContext, appManager.container.viewContext)

                case .allStations:
                    AllStationsView()
                        .environmentObject(appManager)
                }

                CustomTabBarView(selectedTab: $selectedTab)
                    .environmentObject(appManager)
                Spacer()

            }
            .navigationViewStyle(.stack)
            .ignoresSafeArea()
            .dynamicTypeSize(.xSmall ... .xLarge)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ToolbarName()
                        .environmentObject(appManager)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    ToolbarProfile()
                        .environmentObject(appManager)
                }
            }
            .background(DS.Colors.darkBlue)
        }
    
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
