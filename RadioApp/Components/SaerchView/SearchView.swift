//
//  SearchView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct SearchView: View {

    @EnvironmentObject var appManager: ViewModel
    @State var searchText: String = ""
    @State var submit: Bool = true

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(DS.Colors.graySearch)

            HStack {
                Image("search")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18)

                CustomTextField(placeholder: Text("Search radio station").foregroundColor(.white), text: $appManager.searchText)
                    .font(.custom(DS.Fonts.sfRegular, size: 14))
                    .foregroundColor(.white)

                Button {
                    appManager.searchText = ""
                    submit = false
                } label: {
                    SearchButtonView(submit: $submit)
                }
            }
            .padding(.horizontal)

        }
        .frame(width: .infinity, height: 56)
        .padding(.horizontal, 8)
        .cornerRadius(16)
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
    SearchView()
        .environmentObject(ViewModel())
}
