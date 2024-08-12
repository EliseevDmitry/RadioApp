//
//  FavoritesView.swift
//  RadioApp
//
//  Created by Evgeniy K on 01.08.2024.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    @EnvironmentObject var appManager: HomeViewModel
    @FetchRequest(sortDescriptors: []) var stationData: FetchedResults<StationData>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack{
            HStack {
                Text("Favorites")
                    .font(.custom(DS.Fonts.sfRegular, size: 30))
                    .foregroundStyle(.white)
                Spacer()
                //deleteRecords()
                //Button("DeleteData"){
                //deleteRecords()
                //}
            }
            .padding(.leading, 60)
            .padding(.top, 100)
            .background(DS.Colors.darkBlue)
            HStack{
                VolumeView(rotation: false)
                    .frame(width: 33 ,height: 250)
                    .padding(.leading, 15)
                VStack {
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVStack {
                            ForEach(appManager.stations, id: \.stationuuid) {item in
                                FavoritesComponentView(
                                    selectedStationID: $appManager.selectedStation,
                                    station: item
                                )
                            }
                        }
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .background(DS.Colors.darkBlue)
        .onDisappear{
            if !appManager.isActiveDetailView {
                appManager.stopAudioStream()
            }
        }
        .onAppear{
            if !appManager.isActiveDetailView {
                if appManager.setStations(stationData: Array(stationData)) {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        appManager.playFirstStation()
                    }
                    print(appManager.stations)
                }
            } else {
                return
            }
        }
    }
    
    // delete all records
    func deleteRecords() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StationData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try moc.persistentStoreCoordinator?.execute(deleteRequest, with: moc)
            print("данные удалены")
        } catch let error as NSError {
            print("Fetch failed. \(error.localizedDescription)")
        }
        try? moc.save()
        _ = appManager.setStations(stationData: Array(stationData))
    }
}

//MARK: - PREVIEW
struct FavoritesView_Previews: PreviewProvider {
    static let previewAppManager = HomeViewModel()
    static var previews: some View {
        FavoritesView()
            .environmentObject(previewAppManager)
    }
}
