//
//  StationPopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct StationPopularView: View {
    @Binding var voteCount: Int?
    var model: ViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .scaledToFit()
                .foregroundStyle(DS.Colors.pinkNeon)
                .clipShape(.rect(cornerRadius: 20))
              
            VStack{
                
                HStack{
                    Image(.play)
                        .resizable()
                        .frame(
                            width: 50,
                            height: 50
                        )
                    Spacer()
                    Text("votes \(voteCount ?? 0)")
                        .font(.custom(DS.Fonts.sfRegular, size: 50))
                        .foregroundStyle(.white)
                    VoteView(model: model)
                        .frame(
                            width: 30,
                            height: 30
                        )
                }
                .padding(.horizontal)
                Text("POP")
                    .foregroundStyle(.white)
                    .font(.custom(DS.Fonts.sfBold, size: 80))
                Text("Radio Record")
                    .foregroundStyle(.white)
                    .font(.custom(DS.Fonts.sfBold, size: 20))
                Image(.testSpline)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                
            }
            .frame(maxWidth: 300, maxHeight: 300)
        }
        .frame(maxWidth: 300, maxHeight: 300)
    }
}



#Preview {
    StationPopularView(voteCount: .constant(1), model: ViewModel())
}
