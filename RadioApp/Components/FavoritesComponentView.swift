//
//  FaviritesComponentView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 08.08.2024.
//



import SwiftUI



struct FavoritesComponentView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var appManager: ViewModel
    @Binding var selectedStationID: String
    var station: Station
    //MARK: - BODY
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedStationID == station.stationuuid ? DS.Colors.pinkNeon : .clear)
            Button {
                // on tap
               
            } label: {
                // code, name, playing now
                HStack{
                    VStack(alignment: .leading, spacing: 10) {
                            Text(appManager.getString(tags: self.station.tags)?.uppercased() ?? self.station.countrycode)
                                .font(.custom(DS.Fonts.sfBold, size: appManager.getString(tags: self.station.tags) != nil ? 20 : 30))
                            .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.frame)
                        HStack {
                            Spacer()
                            Text(station.name)
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .font(.custom(.sfRegular, size: 10))
                                    .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.frame)
                            Spacer()
                        }
                        if selectedStationID == station.stationuuid {
                            SplineView(isActive: true)
                                .frame(height: 20)
                        } else {
                            SplineView(isActive: false)
                                .frame(height: 20)
                        }
                    }
                    .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.grayNotActive)
                    Spacer(minLength: 80)
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 62, height: 54)
                        .foregroundStyle(DS.Colors.blueNeon)
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
    }
}


//MARK: - PREVIEW
struct FaviritesComponentView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        FavoritesComponentView(selectedStationID: .constant(""), station: .testStation())
            .environmentObject(previewAppManager)
    }
}


