//
//  VoteView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct VoteView: View {
    @EnvironmentObject var appManager: ViewModel
    @Environment(\.managedObjectContext) var moc
    var isShow: Bool
    var idStation: String
    var body: some View {
        Button{
            //заменить ID на ID из модели станции
            if !appManager.saveIDLikes(id: idStation) {
                appManager.islike = false
            } else {
                appManager.islike = true
            }
            //пока без проверки на наличие в базе элемента - тестовый вариант
            if let dataStation = appManager.getStationForID(id: idStation) {
                let stationData = StationData(context: moc)
                stationData.stationuuid = dataStation.changeuuid
                stationData.url = dataStation.url
                stationData.name = dataStation.name
                stationData.country = dataStation.countrycode
                stationData.votes = Int32(dataStation.votes)
                try? moc.save()
            }
        } label: {
            Image(systemName: isShow ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
        }
        .task {
            if !appManager.islike {
                print("отправляем запрос на сервер")
            }
        }
       .disabled(!isShow ? true : false)
        
    }
}

//#Preview {
//    VoteView(model: ViewModel(), isShow: .constant(true))
//}
