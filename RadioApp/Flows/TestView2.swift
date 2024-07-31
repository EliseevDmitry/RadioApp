//
//  TestView2.swift
//  RadioApp
//
//  Created by Evgeniy K on 30.07.2024.
//

import SwiftUI

struct TestView2: View {

    let station: Station

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

                    // votes
                    Text("votes \(station.votes)")
                        .font(.custom(DS.Fonts.sfRegular, size: 20))
                        .foregroundStyle(.white)

//                    VoteView(model: <#ViewModel#>)
//                        .frame(
//                            maxWidth: 50,
//                            maxHeight: 50
//                        )
                }
                .padding(.horizontal, 20)

                // short name
                Text(station.countrycode)
                    .foregroundStyle(.white)
                    .font(.custom(DS.Fonts.sfBold, size: 80))

                // station name
                Text(station.name)
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
    TestView2(station: Station.testStation())
}
