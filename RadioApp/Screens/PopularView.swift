//
//  PopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 31.07.2024.
//

import SwiftUI

struct PopularView: View {
    //MARK: - PROPERTIES
    @ObservedObject var appManager: ViewModel
    let columns = [
        GridItem(.flexible(minimum: 139, maximum: 139)),
        GridItem(.flexible(minimum: 139, maximum: 139))
    ]
    //MARK: - BODY
    var body: some View {
            VStack{
                HStack {
                    Text("Popular")
                        .font(.custom(DS.Fonts.sfRegular, size: 30))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.leading, 60)
                .padding(.top, 100)
                .background(DS.Colors.darkBlue)
                HStack{
                    VolumeView(appManager: appManager, rotation: false)
                        .frame(width: 33 ,height: 250)
                        .padding(.leading, 15)
                    VStack {
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVGrid(columns: columns) {
                                ForEach(appManager.stations, id: \.stationuuid) {item in
                                    StationPopularView(appManager: appManager, selectedStationID: $appManager.selectedStation, station: item)
                                        .frame(width: 139, height: 139)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        .background(DS.Colors.darkBlue)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolbarName(appManager: appManager)
            }
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarProfile(appManager: appManager)
            }
        }
        .task {
            if !appManager.isActiveDetailView {
                do {
                    try await appManager.fetchTopStations()
                } catch let err{
                    // handle error
                    print(err.localizedDescription)
                }
                appManager.playFirstStation()
            } else {
                return
            }
        }
        .onAppear{
            appManager.loadLikesData()
            //clear Set Likes
//            appManager.likes.likeSet.removeAll()
//            appManager.saveLikesData()
        }
        .onDisappear{
            if !appManager.isActiveDetailView{
                appManager.stopAudioStream()
            }
        }
    }
}

//MARK: - PREVIEW
struct PopularView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        PopularView(appManager: previewAppManager)
    }
}




