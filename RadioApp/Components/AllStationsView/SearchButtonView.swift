//
//  ChevronView.swift
//  RadioApp
//
//  Created by Evgeniy K on 02.08.2024.
//

import SwiftUI

struct SearchButtonView: View {
    //MARK: - PROPERTIES
    @Binding var isSearching: Bool
    //MARK: - BODY
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

//MARK: - PREVIEW
#Preview {
    SearchButtonView(isSearching: .constant(false))
}
