//
//  VoteView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct VoteView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var appManager: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var stationsData: FetchedResults<StationData>
    var isShow: Bool
    var idStation: String
    //MARK: - BODY
    var body: some View {
        Button{
            if !appManager.saveIDLikes(id: idStation) {
                appManager.islike = false
            } else {
                appManager.islike = true
                //голосование за любимую станцию
                Task{
                    //Идеальный формат работы:
                    //Функция голосования за любимую станцию
                    try? await appManager.voteStationByID(id: idStation)
                    //Функция - получения обновленных данных по текущей аудио станции после голосования
                    //Работает не корректно, из-за ограничений по конкретному IP адресу, а так-же из-за скорости обновления данных на сервере
                    //try? await appManager.getOneStationByID(id: idStation)
                    
                    //Функция инкремента текущей станции для отображения работоспособности функции getOneStationByID(id: idStation)
                    appManager.updateVotesWithoutRequest(idStation: idStation)
                }
            }
            //вынести в функцию appManager
            if let dataStation = appManager.getStationForID(id: idStation) {
                let stationData = StationData(context: moc)
                if !appManager.containsElementCoreData(
                    stationData: Array(stationsData),
                    idStation: idStation)
                {
                    stationData.stationuuid = dataStation.stationuuid
                    stationData.name = dataStation.name
                    stationData.url = dataStation.url
                    stationData.favicon = dataStation.favicon
                    stationData.tags = dataStation.tags
                    stationData.countrycode = dataStation.countrycode
                    stationData.votes = Int32(dataStation.votes)
                    try? moc.save()
                } else {
                    moc.reset()
                }   
            }
        } label: {
            Image(systemName: isShow ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
        }
//        .task {
//            if !appManager.islike {
//                //print("отправляем запрос на сервер")
//            }
//        }
        .disabled(!isShow ? true : false)
    }
}

//MARK: - PREVIEW
struct VoteView_Previews: PreviewProvider {
    static let previewAppManager = HomeViewModel()
    static var previews: some View {
        VoteView(isShow: .random(), idStation: Station.testStation().stationuuid)
            .environmentObject(previewAppManager)
    }
}
