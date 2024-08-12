//
//  StationDetailsView.swift
//  RadioApp
//
//  Created by Evgeniy K on 09.08.2024.
//

import SwiftUI



struct StationDetailsView: View {
    //MARK: - PROPERTIES
    @ObservedObject var appManager: ViewModel
    var station: Station
    //MARK: - BODY
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VoteView(appManager: appManager, isShow: true, idStation: station.stationuuid)
                    .frame(width: 14, height: 14)
                    .padding(.top, 30)
            }
            .padding(.horizontal, 30)
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
                Text(appManager.getString(tags: self.station.tags)?.uppercased() ?? self.station.countrycode)
                    .font(.custom(DS.Fonts.sfBold, size: appManager.getString(tags: self.station.tags) != nil ? 20 : 30))
                    .foregroundStyle(.white)
                Spacer()
            }
            Spacer()
            HStack(spacing: 30) {
                BackButtonView(appManager: appManager)
                    .disabled(true)
                PlayButtonView(appManager: appManager)
                ForwardButtonView(appManager: appManager)
                    .disabled(true)
            }
            .padding(.bottom, 80)
        }
        .overlay(content: {
            VolumeView(appManager: appManager, rotation: true)
                .frame(height: 300)
                .offset(CGSize(width: 0.0, height: 350.0))
        })
        .overlay(content: {
            EqualizerView(appManager: appManager)
                .offset(CGSize(width: 0.0, height: 170))
        })
        .background(DS.Colors.darkBlue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Playing now")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackBarButton()
            }
        }
        .onDisappear{
            appManager.isActiveDetailView = false
            
        }
    }
}

//MARK: - PREVIEW
#Preview {
    StationDetailsView(appManager: ViewModel(), station: Station.testStation())
}
