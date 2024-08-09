//
//  StationDetailsView.swift
//  RadioApp
//
//  Created by Evgeniy K on 09.08.2024.
//

import SwiftUI

struct StationDetailsView: View {

    @EnvironmentObject var appManager: ViewModel
    var station: Station

    var body: some View {

        ZStack {

            VStack {
                HStack {
                    Spacer()
                    VoteView(isShow: true, idStation: station.stationuuid)
                        .frame(width: 14, height: 14)
                }

                EqualizerView()
                Spacer()
            }

            VStack {
                AsyncImage(url: URL(string: station.favicon)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 40)

                } placeholder: {
                    Color.gray
                }
                .clipShape(Rectangle())
                .frame(maxWidth: 60, maxHeight: 60)

                Text(station.name)
                    .font(.custom(.sfRegular, size: 16))
                    .foregroundStyle(.white)

                Spacer()
            }

            Spacer()
        }
        .background(DS.Colors.darkBlue)
    }
}

#Preview {
    StationDetailsView(station: Station.testStation())
        .environmentObject(ViewModel())
}
