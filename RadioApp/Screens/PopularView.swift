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
    @State private var isActive = false
    let columns = [
        GridItem(.flexible(minimum: 139, maximum: 139)),
        GridItem(.flexible(minimum: 139, maximum: 139))
    ]
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Popular")
                            .font(.custom(DS.Fonts.sfRegular, size: 30))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 60)
                    .padding(.top, 10)
                    HStack{
                        VolumeView(rotation: false)
                            .frame(width: 33 ,height: 250)
                            .padding(.leading, 15)
                        
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVGrid(columns: columns) {
                                ForEach(appManager.stations, id: \.stationuuid) {item in
                                  
                                        StationPopularView(selectedStationID: $appManager.selectedStation, station: item)
                                            .frame(width: 139, height: 139)
                                }
                            }
                            .background(DS.Colors.darkBlue)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .background(DS.Colors.darkBlue)
            }
        }
        .padding(.top, 100)
        .navigationViewStyle(.stack)
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
            //clear Set Likes
            //appManager.likes.likeSet.removeAll()
            //appManager.saveLikesData()
        }
        .onDisappear{
            appManager.stopAudioStream()
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




