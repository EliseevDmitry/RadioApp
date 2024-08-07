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
                .fill(selectedStationID == station.stationuuid ? DS.Colors.pinkNeon : .clear)

            Button {
                // on tap
                selectedStationID = station.stationuuid
                appManager.playAudio(url: station.url)
            } label: {
                // code, name, playing now
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(station.tags)
                            .font(.custom(.sfBold, size: 30))

                        Text(station.name)
                            .font(.custom(.sfRegular, size: 15))


                        // now playing
                        if selectedStationID == station.stationuuid {
                            Text("Playing now")
                                .font((.custom(.sfBold, size: 14)))
                                .foregroundStyle(DS.Colors.pinkPlaying)
                        }

                        Spacer()
                    }
                    .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.grayNotActive)

                    Spacer()

                    HStack {
                        VStack(alignment: .trailing) {
                            HStack {
                                Text("votes \(self.station.votes % 1000)")
                                    .font(.custom(DS.Fonts.sfRegular, size: 14))
                                    .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.frame)

                                VoteView(isShow: selectedStationID == station.stationuuid ? true : false, idStation: station.stationuuid)
                                    .frame(width: 14, height: 14)
                            }

                            Spacer(minLength: 20)

                                SplineView(isActive: selectedStationID == station.stationuuid ? true : false)
                                    .frame(width: 90, height: 18)
                                    .padding(.horizontal)
                                    .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.grayNotActive)

                            Spacer()
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
                .stroke(selectedStationID == station.stationuuid ? DS.Colors.pinkNeon : DS.Colors.frame, lineWidth: 2)
        }
        .padding(.trailing, 20)
        .padding(.vertical, 5)
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}