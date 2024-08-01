//
//  PopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 31.07.2024.
//

import SwiftUI

struct PopularView: View {
    @EnvironmentObject var appManager: ViewModel
   // @ObservedObject var appManager: ViewModel
    @State private var selectedStation = ""
    let columns = [
        GridItem(.flexible(minimum: 139, maximum: 139)),
        GridItem(.flexible(minimum: 139, maximum: 139))
    ]
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
                VolumeView(voulmeValue: $appManager.volume)
                    .frame(width: 33 ,height: 250)
                    .padding(.leading, 15)
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(columns: columns) {
                        ForEach(appManager.stations, id: \.changeuuid) {item in
                            StationPopularView(selectedStationID: $selectedStation, station: item)
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
//            PlayerMenuView()
//                .padding(.bottom, 50)
        }
        
        .ignoresSafeArea()
        .background(DS.Colors.darkBlue)
        .task {
            do {
                appManager.stations = try await appManager.network.getTopStations(numberLimit: 20)
            } catch {
                // handle error
            }
        }
    }
    
//    func removeItems(at offsets: IndexSet, from arrayExpense: [ExpenseItem]) {
//        for offset in offsets {
//            let item = arrayExpense[offset]
//            expenses.items.removeAll { element in
//                element.id == item.id
//            }
//        }
//    }
    
}

struct PopularView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        PopularView()
            .environmentObject(previewAppManager)
    }
}
