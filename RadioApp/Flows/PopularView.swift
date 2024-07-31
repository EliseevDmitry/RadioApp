//
//  PopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 31.07.2024.
//

import SwiftUI

struct PopularView: View {
    @EnvironmentObject var appManager: ViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var stations = [Station]()
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Popular")
                    .font(.custom(DS.Fonts.sfRegular, size: 40))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
            HStack{
                VolumeView(voulmeValue: $appManager.volume)
                    .frame(width: 33 ,height: 250)
                    .padding(.leading, 15)
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(columns: columns) {
//                        ForEach(stations, id: \.voteCount) {item in
//                            item
//                                //.padding(4)
//                              
//                        }
                    }
                }
                .padding()
            }
            Spacer()
            PlayerMenuView()
           Spacer()
        }
        .ignoresSafeArea()
        .background(DS.Colors.darkBlue)
        .task {
            stations = try await appManager.network.getTopStations(numberLimit: 20)
        }
    }
        
}

struct PopularView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()

    static var previews: some View {
        PopularView()
            .environmentObject(previewAppManager)
    }
}
