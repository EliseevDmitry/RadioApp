//
//  ChevronCyrcleView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

struct ChevronCircleView: View {
    // MARK: - Drawing Constants
    private enum Drawing {
        static let frameSize: CGFloat = 50
        static let iconPadding: CGFloat = 15
        static let iconSize: CGFloat = 24
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
    ChevronCircleView()
}
