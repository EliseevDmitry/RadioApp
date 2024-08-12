//
//  FaviritesComponentView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 08.08.2024.
//



import SwiftUI

struct FavoritesComponentView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var appManager: HomeViewModel
    @FetchRequest(sortDescriptors: []) var stationData: FetchedResults<StationData>
    @Environment(\.managedObjectContext) var moc
    @Binding var selectedStationID: String
    @State private var isActive = false
    //@State private var isActive = false
    var station: Station
    //MARK: - BODY
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedStationID == station.stationuuid ? DS.Colors.pinkNeon : .clear)
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    Text(appManager.getString(tags: self.station.tags)?.uppercased() ?? self.station.countrycode)
                        .font(.custom(DS.Fonts.sfBold, size: appManager.getString(tags: self.station.tags) != nil ? 20 : 30))
                        .foregroundStyle(selectedStationID == station.stationuuid ? .blue : DS.Colors.frame)
                    HStack() {
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
                .frame(width: 120, height: 120)
                .foregroundStyle(selectedStationID == station.stationuuid ? .white : DS.Colors.grayNotActive)
                Spacer(minLength: 80)
                Button{
                    deleteItem()
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 62, height: 54)
                        .foregroundStyle(DS.Colors.blueNeon)
                }
            }
            .padding()
            
        }
    
        .frame(width: 293, height: 120)
        .background(NavigationLink(
            destination: StationDetailsView(station: station),
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
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(selectedStationID == station.stationuuid ? DS.Colors.pinkNeon : DS.Colors.frame, lineWidth: 2)
        }
}
    func deleteItem(){
        appManager.pauseAudioStream()
        if let id = appManager.getIndexStations(idStation: station.stationuuid){
            let station = stationData[id]
            moc.delete(station)
            try? moc.save()
            _ = appManager.setStations(stationData: Array(stationData))
            print(appManager.stations.count)
            if appManager.stations.count > 0 {
                appManager.playFirstStation()
            } else {
                appManager.stopAudioStream()
            }
        }
    }
}


//MARK: - PREVIEW
//struct FaviritesComponentView_Previews: PreviewProvider {
//    static let previewAppManager = ViewModel()
//    static var previews: some View {
//        FavoritesComponentView(selectedStationID: .constant(""), station: .testStation())
//            .environmentObject(previewAppManager)
//    }
//}


