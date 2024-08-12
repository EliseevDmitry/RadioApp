//
//  AllStationsView.swift
//  RadioApp
//
//  Created by Evgeniy K on 01.08.2024.
//

import SwiftUI

struct AllStationsView: View {
    @EnvironmentObject var appManager: HomeViewModel
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
            SearchBarView(isSearching: $isSearching)
                .frame(height: 56)
            Spacer()
            HStack{
                VolumeView(rotation: false)
                    .frame(width: 33 ,height: 250)
                    .padding(.leading, 15)
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(pinnedViews: .sectionHeaders) {
                            ForEach(appManager.stations, id: \.stationuuid) { station in
                                NavigationLink {
                                    StationDetailsView(station: station)
                                    
                                } label: {
                                    StationView(selectedStationID: $appManager.selectedStation, station: station)
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
struct AllStationsView_Previews: PreviewProvider {
    static let previewAppManager = HomeViewModel()
    static var previews: some View {
        AllStationsView()
            .environmentObject(previewAppManager)
    }
}
