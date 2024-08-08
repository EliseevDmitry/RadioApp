//
//  FavoritesView.swift
//  RadioApp
//
//  Created by Evgeniy K on 01.08.2024.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    @EnvironmentObject var appManager: ViewModel
    @FetchRequest(sortDescriptors: []) var stationData: FetchedResults<StationData>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Text("Favorites")
                        .font(.custom(DS.Fonts.sfRegular, size: 30))
                        .foregroundStyle(.white)
                    Button("DeleteData"){
                        deleteRecords()
                        
                    }
                    Spacer()
                }
                .padding(.leading, 60)
                .padding(.top, 10)
                HStack{
                    VolumeView()
                        .frame(width: 33 ,height: 250)
                        .padding(.leading, 15)
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
            }
            .background(DS.Colors.darkBlue)
            .navigationViewStyle(.stack)
            .onDisappear{
                appManager.isPlay = false
            }
            .onAppear{
                if appManager.setStations(stationData: Array(stationData)) {
                    appManager.playFirstStation()
                }
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
//        try? moc.save()
//        setStations()
    }
    

}

//MARK: - PREVIEW
struct FavoritesView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        FavoritesView()
            .environmentObject(previewAppManager)
        
    }
}
