//
//  EditPhotoButttonView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 03.08.2024.
//


import SwiftUI

struct EditPhotoButtonView: View {
    // MARK: - Properties
    let title: String
    let image: String
    let action: () -> Void
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let iconSize: CGFloat = 20
        static let iconPadding: CGFloat = 8
        static let buttonPadding: CGFloat = 10
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            HStack {
                // MARK: - Title
                Text(title)
                    .padding(.leading, DrawingConstants.buttonPadding)
                
                Spacer()
                
                // MARK: - Icon
                Image(systemName: image)
                    .resizable()
                    .frame(
                        width: DrawingConstants.iconSize,
                        height: DrawingConstants.iconSize
                    )
                    .padding(.trailing, DrawingConstants.buttonPadding)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview
#Preview {
    EditPhotoButtonView(
        title: "Take photo",
        image: "camera.shutter.button",
        action: {}
    )
}
