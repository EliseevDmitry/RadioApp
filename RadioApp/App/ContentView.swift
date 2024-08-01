//
//  ContentView.swift
//  RadioApp
//
//  Created by Evgeniy K on 31.07.2024.
//

import SwiftUI

struct ContentView: View {

    @State var currentTab: Tab = .popular
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack {
            TabView(selection: $currentTab) {
                Text("Popular")
                    .tag(Tab.popular)

                Text("Favorites")
                    .tag(Tab.favorites)

                Text("All Stations")
                    .tag(Tab.allStations)
            }

            CustomTabBarView(currentTab: $currentTab)
            
        }
    }
}

#Preview {
    ContentView()
}
