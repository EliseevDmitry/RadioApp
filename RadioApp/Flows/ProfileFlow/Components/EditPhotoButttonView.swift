//
//  EditPhotoButttonView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 03.08.2024.
//

import SwiftUI

struct EditPhotoButttonView: View {
    // MARK: - Properties
    let title: String
    let image: String
    let action: () ->Void
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let iconSize: CGFloat = 20
        static let iconPadding: CGFloat = 8
        static let buttonPadding: CGFloat = 10
    }
    // MARK: - Body
    var body: some View {
        HStack {
            Button(action: action) {
                Text(title)
                    .padding()
                
                Image(systemName: title)
                    .resizable()
                    .frame(
                        width: DrawingConstants.iconSize,
                        height: DrawingConstants.iconSize
                    )
//                    .padding(.leading, DrawingConstants.iconPadding)
            }
        }
    }
}

#Preview {
    EditPhotoButttonView(
        title: "Take photo",
        image: "trash",
        action: {}
    )
}
