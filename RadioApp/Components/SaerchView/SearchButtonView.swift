//
//  ChevronView.swift
//  RadioApp
//
//  Created by Evgeniy K on 02.08.2024.
//

import SwiftUI

struct SearchButtonView: View {

    @Binding var submit: Bool

    var body: some View {
        Image(systemName: submit ? "chevron.right" : "xmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .padding(8)
            .foregroundColor(DS.Colors.blueNeon)
            .background(Circle().fill(DS.Colors.graySearchImage))
    }
}

#Preview {
    SearchButtonView(submit: .constant(false))
}
