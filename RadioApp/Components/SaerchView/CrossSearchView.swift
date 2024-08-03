//
//  CrossView.swift
//  RadioApp
//
//  Created by Evgeniy K on 02.08.2024.
//

import SwiftUI

struct CrossSearchView: View {
    // MARK: - Drawing Constants
    private enum Drawing {
        static let frameWidth: CGFloat = 50
        static let frameHeight: CGFloat = 50
        static let iconPadding: CGFloat = 12
        static let iconSize: CGFloat = 20
    }
    
    var body: some View {
        Image(systemName: "xmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(Drawing.iconPadding)
            .foregroundColor(DS.Colors.blueNeon)
            .background(Circle().fill(.black))
            .frame(width: Drawing.frameWidth, height: Drawing.frameHeight)
    }
}

#Preview {
    CrossSearchView()
}
