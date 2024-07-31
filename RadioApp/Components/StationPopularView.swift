//
//  StationPopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct StationPopularView: View {
    @Binding var voteCount: Int?
    @Binding var isShow: Bool
    var model: ViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .scaledToFit()
                .foregroundStyle(isShow ? DS.Colors.pinkNeon : Color.clear)
            
                .clipShape(.rect(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            isShow ? DS.Colors.pinkNeon : DS.Colors.darkBlue, lineWidth: 2
                        )
                )
            VStack{
                HStack{
                    if isShow {
                        Image(.play)
                            .resizable()
                            .frame(
                                width: 25,
                                height: 25
                            )
                    }
                    Spacer()
                    Text("votes \(voteCount ?? 0)")
                        .font(.custom(DS.Fonts.sfRegular, size: 15))
                        .foregroundStyle(isShow ? .white : DS.Colors.darkBlue)
                    VoteView(model: model, isShow: $isShow)
                        .frame(
                            width: 14,
                            height: 14
                        )
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Spacer()
                Text("Radio Record")
                    .foregroundStyle(isShow ? .white : DS.Colors.darkBlue)
                    .font(.custom(DS.Fonts.sfRegular, size: 15))
                Image(.testSpline)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
            }
            .frame(maxWidth: 139, maxHeight: 139)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: 139, maxHeight: 139)
        .overlay {
            Text("POP")
                .foregroundStyle(isShow ? .white : DS.Colors.darkBlue)
                .font(.custom(DS.Fonts.sfBold, size: 40))
                .offset(CGSize(width: 0.0, height: -15.0))
        }
    }
}



#Preview {
    StationPopularView(voteCount: .constant(1), isShow: .constant(true), model: ViewModel())
}
