//
//  PopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 31.07.2024.
//

import SwiftUI

struct PopularView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var appManager: ViewModel
    let columns = [
        GridItem(.flexible(minimum: 139, maximum: 139)),
        GridItem(.flexible(minimum: 139, maximum: 139))
    ]
    //MARK: - BODY
    var body: some View {
        VStack {
            HStack {
                Text("Popular")
                    .font(.custom(DS.Fonts.sfRegular, size: 40))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 60)
            Spacer()
            HStack{
                VolumeView()
                    .frame(width: 33 ,height: 250)
                    .padding(.leading, 15)
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(columns: columns) {
                        ForEach(appManager.stations.shuffled(), id: \.changeuuid) {item in
                            StationPopularView(selectedStationID: $appManager.selectedStation, station: item)
                                .environmentObject(appManager)
                                .frame(width: 139, height: 139)
                        }
                    }
                }
                .padding()
                .overlay {
                    HStack(spacing: 30){
                        BackButtonView()
                        PlayButtonView()
                        ForwardButtonView()
                    }
                    .offset(CGSize(width: 0, height: 260))
                }
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(DS.Colors.darkBlue)
        .task {
            do {
                try await appManager.fetchTopStations()
            } catch let err{
                // handle error
                print(err.localizedDescription)
            }
            appManager.playFirstStation()
        }
        .onAppear{
            appManager.loadLikesData()
        }
    }
}

//MARK: - PREVIEW
struct PopularView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        PopularView()
            .environmentObject(previewAppManager)
    }
}




