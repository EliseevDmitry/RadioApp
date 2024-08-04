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

            VStack {
                Text("All stations")
                    .font(.custom(DS.Fonts.sfRegular, size: 30))
                    .foregroundStyle(.white)

                SearchView(searchText: "")

                Spacer()

                HStack {

                    // sound control
                    VStack {
                        VolumeView(voulmeValue: $appManager.volume)
                            .frame(width: 33 ,height: 250)
                            .padding(.leading, 15)
                    }

                    // stations + play buttons
                    VStack {
//                        StationView(station: appManager.stations)
                    }

                    Spacer()
                }

            }
            .background(DS.Colors.darkBlue)
        }
    }
}

#Preview {
    AllStationsView()
        .environmentObject(ViewModel())
}
