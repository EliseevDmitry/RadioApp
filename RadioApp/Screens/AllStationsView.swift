//
//  AllStationsView.swift
//  RadioApp
//
//  Created by Evgeniy K on 01.08.2024.
//

import SwiftUI

struct AllStationsView: View {

    @EnvironmentObject var appManager: ViewModel

    var body: some View {
        NavigationView {

            // text
            VStack {
                HStack {
                    Text("All stations")
                        .font(.custom(DS.Fonts.sfRegular, size: 30))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.leading, 60)

                // search view
                SearchView(searchText: "")

                Spacer()

                HStack {

                    // sound control
                    VStack {
                        VolumeView(voulmeValue: $appManager.volume)
                            .frame(width: 30 ,height: 253)
                            .padding(.leading, 5)
                    }

                    // stations
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack {
                                ForEach(appManager.stations, id: \.stationuuid) { station in
                                    StationView(selectedStationID: $appManager.selectedStation, station: station)
                                }
                            }
                        }

                        // play buttons
                        // вынести в единый компонент с единым позиционированием?
                        VStack {
                            Spacer()

                            HStack(spacing: 45) {
                                BackButtonView()
                                PlayButtonView()
                                ForwardButtonView()
                            }
                        }
                        .frame(width: 255, height: 150)
                        .offset(x: -15, y: -20)
                    }
                    Spacer()
                }
                Spacer()
            }
            .background(DS.Colors.darkBlue)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
