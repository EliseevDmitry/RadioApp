//
//  AllStationsView.swift
//  RadioApp
//
//  Created by Evgeniy K on 01.08.2024.
//

import SwiftUI

struct AllStationsView: View {
    //@EnvironmentObject var appManager: ViewModel
    @ObservedObject var appManager: ViewModel
    @State private var isSearching: Bool = false
    var body: some View {
        VStack{
            HStack {
                Text("All stations")
                    .font(.custom(DS.Fonts.sfRegular, size: 30))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.leading, 60)
            .padding(.top, 100)
            // search view
            SearchBarView(appManager: appManager, isSearching: $isSearching)
                .frame(height: 56)
            Spacer()
            HStack{
                VolumeView(appManager: appManager, rotation: false)
                    .frame(width: 33 ,height: 250)
                    .padding(.leading, 15)
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(pinnedViews: .sectionHeaders) {
                            ForEach(appManager.stations, id: \.stationuuid) { station in
                                NavigationLink {
                                    StationDetailsView(appManager: appManager, station: station)
                                    
                                } label: {
                                    StationView(appManager: appManager, selectedStationID: $appManager.selectedStation, station: station)
                                }
                                
                            }
                        }
                        .background(DS.Colors.darkBlue)
                        .navigationViewStyle(.stack)
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .background(DS.Colors.darkBlue)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolbarName(appManager: appManager)
            }
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarProfile(appManager: appManager)
            }
        }
        .task {
            if !appManager.isActiveDetailView {
                do {
                    try await appManager.fetchAllStations()
                } catch {
                    print(error)
                }
                appManager.playFirstStation()
            } else {
                return
            }
        }
        .onDisappear{
            if !appManager.isActiveDetailView{
                appManager.stopAudioStream()
            }
        }
    }
}

//MARK: - PREVIEW
//struct AllStationsView_Previews: PreviewProvider {
//    static let previewAppManager = ViewModel()
//    static var previews: some View {
//        AllStationsView()
//            .environmentObject(previewAppManager)
//    }
//}
