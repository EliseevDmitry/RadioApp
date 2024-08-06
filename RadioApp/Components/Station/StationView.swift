//
//  StationView.swift
//  RadioApp
//
//  Created by Evgeniy K on 02.08.2024.
//

import SwiftUI

struct StationView: View {

    @EnvironmentObject var appManager: ViewModel
    @Binding var selectedStationID: String
    var station: Station

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedStationID == station.changeuuid ? DS.Colors.pinkNeon : .clear)

            Button {
                // on tap
                selectedStationID = station.changeuuid
                appManager.playAudio(url: station.url)
            } label: {
                // code, name, playing now
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(station.tags.uppercased())
                            .font(.custom(.sfBold, size: 30))

                        Text(station.name)
                            .font(.custom(.sfRegular, size: 15))

                        // now playing
                        if selectedStationID == station.changeuuid {
                            Text("Playing now")
                                .font((.custom(.sfBold, size: 14)))
                                .foregroundStyle(DS.Colors.pinkPlaying)
                        }

                        Spacer()
                    }
                    .foregroundStyle(selectedStationID == station.changeuuid ? .white : DS.Colors.grayNotActive)

                    Spacer()

                    HStack {
                        VStack(alignment: .trailing) {
                            //                        VoteView(isShow: selectedStationID == station.stationuuid ? true : false, idStation: station.stationuuid)

                            SplineView(isActive: selectedStationID == station.changeuuid ? true : false)
                                .frame(width: 94, height: 23)
                                .foregroundStyle(selectedStationID == station.changeuuid ? .white : DS.Colors.grayNotActive)
                        }
                    }
                }
                .padding()
            }

        }
        .frame(width: 293, height: 120)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(selectedStationID == station.changeuuid ? DS.Colors.pinkNeon : DS.Colors.frame, lineWidth: 2)
        }
        .padding(.trailing, 20)
        .padding(.vertical, 5)
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
