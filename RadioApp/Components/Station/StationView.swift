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

        HStack {

            // code, name, playing now
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(station.countrycode.uppercased())
                        .font(.custom(.sfBold, size: 30))
                        .foregroundStyle(DS.Colors.grayNotActive)

                    Text(station.name)
                        .font(.custom(.sfRegular, size: 15))
                        .foregroundStyle(DS.Colors.grayNotActive)

                    // now playing

                    Spacer()
                }

                Spacer()

                HStack {
                    VStack(alignment: .trailing) {
                        //                        VoteView(isShow: selectedStationID == station.stationuuid ? true : false, idStation: station.stationuuid)

                        SplineView(isActive: true)
                            .frame(width: 94, height: 23)
                            .foregroundStyle(selectedStationID == station.changeuuid ? .white : DS.Colors.grayNotActive)
                    }
                }
            }
            .padding()

        }
        .foregroundStyle(selectedStationID == station.changeuuid ? .white : DS.Colors.grayNotActive)
        .frame(maxWidth: 293, maxHeight: 90)
        .padding(.vertical)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(selectedStationID == station.changeuuid ? DS.Colors.pinkNeon : DS.Colors.frame, lineWidth: 2.0)
        }
        .padding(.trailing, 20)
        .padding(.vertical, 5)

    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
