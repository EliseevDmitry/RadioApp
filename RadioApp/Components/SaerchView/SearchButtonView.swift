//
//  ChevronView.swift
//  RadioApp
//
//  Created by Evgeniy K on 02.08.2024.
//

import SwiftUI

struct SearchButtonView: View {

    @Binding var isSearching: Bool

    var body: some View {
        Image(systemName: isSearching ? "xmark" : "chevron.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .padding(8)
            .foregroundColor(DS.Colors.blueNeon)
            .background(Circle().fill(DS.Colors.graySearchImage))
    }
}

#Preview {
    SearchButtonView(isSearching: .constant(false))
}
