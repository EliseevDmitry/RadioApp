//
//  StationPopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct StationPopularView: View {
    @Binding var voteCount: Int?
    var body: some View {
        ZStack {
            Rectangle()
                .scaledToFit()
                .foregroundStyle(DS.Colors.pinkNeon)
                .clipShape(.rect(cornerRadius: 20))
            VStack {
                HStack{
                    Image(.play)
                        .resizable()
                        .frame(
                            maxWidth: 80,
                            maxHeight: 80
                        )
                    Spacer()
                    Text("votes \(voteCount ?? 0)")
                        .font(.custom(DS.Fonts.sfRegular, size: 20))
                        .foregroundStyle(.white)
                    VoteView()
                        .frame(
                            maxWidth: 50,
                            maxHeight: 50
                        )
                }
                .padding(.horizontal, 20)
                Text("POP")
                    .foregroundStyle(.white)
                    .font(.custom(DS.Fonts.sfBold, size: 80))
                Text("Radio Record")
                    .foregroundStyle(.white)
                    .font(.custom(DS.Fonts.sfBold, size: 30))
                Image(.testSpline)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    StationPopularView(voteCount: .constant(1))
}
