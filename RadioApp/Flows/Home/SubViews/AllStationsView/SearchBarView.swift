//
//  SearchView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct SearchBarView: View {

    @EnvironmentObject var appManager: HomeViewModel
    @State var searchText: String = ""
    @Binding var isSearching: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(DS.Colors.graySearch)
                .padding(.vertical, 0)

            HStack {
                Image("search")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18)

                CustomTextField(placeholder: Text("Search radio station").foregroundColor(.white), text: $appManager.searchText)
                    .font(.custom(DS.Fonts.sfRegular, size: 14))
                    .foregroundColor(.white)

                Button {
                    Task {
                        if isSearching {
                            try await appManager.fetchAllStations()
                            appManager.searchText = searchText
                        } else {
                            try await appManager.fetchSearchStations()
                        }
                        isSearching.toggle()
                    }
                } label: {
                    SearchButtonView(isSearching: $isSearching)
                }
            }
            .padding(.horizontal)
        }
       // .frame(maxWidth: .infinity, maxHeight: 56)
        .padding(.horizontal, 8)
        .padding(.vertical, 0)
    }

    struct CustomTextField: View {
        var placeholder: Text
        @Binding var text: String

        var body: some View {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    placeholder
                        .padding(.leading, 8)
                }
                TextField("", text: $text)
                    .foregroundColor(.white)
                    .padding(4)
            }
        }
    }
}

#Preview {
    SearchBarView(isSearching: .constant(false))
        .environmentObject(HomeViewModel())
}
