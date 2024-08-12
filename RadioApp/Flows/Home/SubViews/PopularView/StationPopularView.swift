//
//  StationPopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct StationPopularView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var appManager: HomeViewModel
    @Binding var selectedStationID: String
    @State private var isActive = false
    var station: Station
    //MARK: - BODY
    var body: some View {
            ZStack{
                Rectangle()
                    .scaledToFit()
                    .foregroundStyle(selectedStationID == station.stationuuid ? DS.Colors.pinkNeon : Color.clear)
                    .clipShape(.rect(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                selectedStationID == station.stationuuid ? DS.Colors.pinkNeon : DS.Colors.frame, lineWidth: 2
                            )
                    )
                VStack{
                    HStack{
                        if selectedStationID == station.stationuuid {
                            Image(systemName: appManager.isPlay ? "play.fill" : "pause.fill")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 25)
                        }
                        Spacer()
                        //отобразить последние 100 голосов
                        Text("votes \(self.station.votes % 1000)")
                            .font(.custom(DS.Fonts.sfRegular, size: 14))
                            .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.frame)
                        VoteView(isShow: selectedStationID == station.stationuuid ? true : false, idStation: station.stationuuid)
                            .frame(
                                width: 14,
                                height: 14
                            )
                    }
                    .frame(height: 25)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    Spacer()
                    Text(self.station.name)
                        .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.frame)
                        .font(.custom(DS.Fonts.sfRegular, size: 15))
                    if selectedStationID == station.stationuuid {
                        SplineView(isActive: true)
                            .frame(height: 20)
                            .padding(.horizontal)
                    } else {
                        SplineView(isActive: false)
                            .frame(height: 20)
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: 139, maxHeight: 139)
                .padding(.bottom, 10)
            }
            .frame(maxWidth: 139, maxHeight: 139)
            //логика нажатия
            .background(NavigationLink(
                destination: StationDetailsView(station: self.station),
                            isActive: $isActive) {
                            EmptyView()
                        })
            .onTapGesture {
                selectedStationID = station.stationuuid
                appManager.playAudio(url: station.url)
            }
            .onLongPressGesture() {
                if selectedStationID == station.stationuuid {
                    print("long tap")
                    isActive.toggle()
                    appManager.isActiveDetailView = true
                }
            }
            .overlay {
                Text(appManager.getString(tags: self.station.tags)?.uppercased() ?? self.station.countrycode)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.frame)
                    .font(.custom(DS.Fonts.sfBold, size: appManager.getString(tags: self.station.tags) != nil ? 20 : 30))
                    .offset(CGSize(width: 0.0, height: -15.0))
            }
    }
    
}


//MARK: - PREVIEW
struct StationPopularView_Previews: PreviewProvider {
    static let previewAppManager = HomeViewModel()
    static var previews: some View {
        StationPopularView(selectedStationID: .constant(""), station: .testStation())
            .environmentObject(previewAppManager)
    }
}
