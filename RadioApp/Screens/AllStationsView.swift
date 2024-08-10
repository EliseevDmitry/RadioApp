//
//  AllStationsView.swift
//  RadioApp
//
//  Created by Evgeniy K on 01.08.2024.
//

import SwiftUI

struct AllStationsView: View {

    @EnvironmentObject var appManager: ViewModel
    @State private var isSearching: Bool = false

    var body: some View {
        VStack {
            // text
            VStack {
                HStack {
                    Text("All stations")
                        .font(.custom(DS.Fonts.sfRegular, size: 30))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.leading, 60)
                .padding(.top, 10)

                // search view
                SearchBarView(isSearching: $isSearching)
                    .frame(height: 56)

                Spacer()
                HStack {
                    // sound control
                    VStack {
                        VolumeView(rotation: false)
                            .frame(width: 33 ,height: 250)
                            .padding(.leading, 15)
                    }

                    // stations
                    NavigationView {
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
                        }
                        .background(DS.Colors.darkBlue)
                        .navigationViewStyle(.stack)
                    }
                    Spacer()
                }
                Spacer()
            }
            .background(DS.Colors.darkBlue)
        }
        .padding(.top, 100)
        .task {
            do {
                try await appManager.fetchAllStations()
            } catch {
                print(error)
            }
            appManager.playFirstStation()
        }
        .onDisappear{
            // appManager.isPlay = false
            appManager.stopAudioStream()
        }
    }
}


//MARK: - PREVIEW
struct AllStationsView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        AllStationsView()
            .environmentObject(previewAppManager)
    }
}
