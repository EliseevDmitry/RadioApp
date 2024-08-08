//
//  FavoritesView.swift
//  RadioApp
//
//  Created by Evgeniy K on 01.08.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appManager: ViewModel
    @FetchRequest(sortDescriptors: []) var stationData: FetchedResults<StationData>
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                ForEach(stationData, id: \.stationuuid) {item in
                    
                    let station = Station(stationuuid: item.stationuuid ?? "", name: item.name ?? "", url: item.url ?? "", favicon: "", tags: "", countrycode: "", votes: item.votes)
                        
                    FavoritesComponentView(selectedStationID: $appManager.selectedStation, station: station) 
                    }
                
            }
        }
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
