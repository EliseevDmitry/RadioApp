//
//  VoteView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct VoteView: View {
    var model: ViewModel
    var isShow: Bool
    @State private var islike = true
    var body: some View {
        Button{
            //заменить ID на ID из модели станции
            if !model.saveIDLikes(id: 1) {
                islike = false
            } else {
                islike = true
            }
        } label: {
            Image(systemName: isShow ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
        }
        .task {
            if !islike {
                print("отправляем запрос на сервер")
            }
        }
        
    }
}

//#Preview {
//    VoteView(model: ViewModel(), isShow: .constant(true))
//}
