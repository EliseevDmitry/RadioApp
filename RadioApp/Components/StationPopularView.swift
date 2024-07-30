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
        GeometryReader{ geometry in
            Rectangle()
                .scaledToFit()
                .foregroundStyle(DS.Colors.pinkNeon)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                    VStack {
                        HStack{
                            Image(.play)
                                .resizable()
                                .frame(
                                    width: geometry.size.width/5,
                                    height: geometry.size.width/5
                                )
                            Spacer()
                            Text("votes \(voteCount ?? 0)")
                                .font(.custom(DS.Fonts.sfRegular, size: geometry.size.width/11))
                                .foregroundStyle(.white)
                            VoteView(model: model)
                                .frame(
                                    width: geometry.size.width/7,
                                    height: geometry.size.width/7
                                )
                        }
                        .padding(.horizontal, geometry.size.width/20)
                        Text("POP")
                            .foregroundStyle(.white)
                            .font(.custom(DS.Fonts.sfBold, size: geometry.size.width/5))
                        Text("Radio Record")
                            .foregroundStyle(.white)
                            .font(.custom(DS.Fonts.sfBold, size: geometry.size.width/10))
                        Image(.testSpline)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, geometry.size.width/20)
                    }
                }
        }
        Spacer()
    }
}


#Preview {
    StationPopularView(voteCount: .constant(1), model: ViewModel())
}
