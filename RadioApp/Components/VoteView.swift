//
//  VoteView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct VoteView: View {
    @EnvironmentObject var appManager: ViewModel
    
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
        
    }
}

//#Preview {
//    VoteView(model: ViewModel(), isShow: .constant(true))
//}
