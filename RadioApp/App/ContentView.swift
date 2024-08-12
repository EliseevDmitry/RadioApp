//
//  ContentView.swift
//  RadioApp
//
//  Created by Evgeniy K on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var appManager: HomeViewModel
    @State private var selectedTab: Tab = .popular
    
    @State private var isProfileViewActive = false
    
    init(
        authService: AuthService = .shared,
        networkService: NetworkService = .shared,
        amplitudeService: AmplitudeService = .shared,
        coreDataService: CoreDataService = .shared
    ) {
        self._appManager = StateObject(
            wrappedValue: HomeViewModel(
                authService: authService,
                networkService: networkService,
                amplitudeService: amplitudeService,
                coreDataService: coreDataService
            )
        )
    }
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .popular:
                PopularView()
                    .environmentObject(appManager)
                
            case .favorites:
                FavoritesView()
                    .environmentObject(appManager)
                
            case .allStations:
                AllStationsView()
                    .environmentObject(appManager)
            }
            
            CustomTabBarView(selectedTab: $selectedTab)
                .environmentObject(appManager)
                .ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ToolbarName()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        ToolbarProfile(toolbarRoute: {
                            withAnimation(.easeInOut) {
                                isProfileViewActive.toggle()
                            }
                        })
                    }
                }
                .environmentObject(appManager)
        }
        .background(
            NavigationLink(destination: ProfileView(),
                           isActive: $isProfileViewActive,
                           label: { EmptyView() })
        )
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    ContentView()
}
