//
//  ChevronView.swift
//  RadioApp
//
//  Created by Evgeniy K on 02.08.2024.
//

import SwiftUI

struct ChevronSearchView: View {
    // MARK: - Drawing Constants
    private enum Drawing {
        static let frameSize: CGFloat = 50
        static let iconPadding: CGFloat = 15
        static let iconSize: CGFloat = 20
    }

    var body: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(Drawing.iconPadding)
            .foregroundColor(DS.Colors.blueNeon)
            .background(Circle().fill(.black))
            .frame(width: Drawing.frameSize, height: Drawing.frameSize)
    }
}

#Preview {
    ChevronSearchView()
}
