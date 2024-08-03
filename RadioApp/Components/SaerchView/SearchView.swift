//
//  SearchView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct SearchView: View {

    @State var searchText = ""

    var body: some View {
        HStack {
            Image("search")
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 16)

            TextField("Search radio station", text: $searchText)
                .font(.custom(DS.Fonts.sfRegular, size: 14))
                .foregroundColor(.white)

            ChevronSearchView()
        }
        .padding(EdgeInsets(top: 7, leading: 8, bottom: 7, trailing: 8))
        .frame(height: 56)
        .background(DS.Colors.graySearch)
        //.foregroundColor(.white.opacity(0.6))
        .cornerRadius(16)
    }
}

#Preview {
    SearchView()
}
