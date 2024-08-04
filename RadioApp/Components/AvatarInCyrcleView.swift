//
//  AvatarInCyrcleView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 04.08.2024.
//

import SwiftUI

struct AvatarInCyrcleView: View {
    // MARK: - Properties
    var avatar: UIImage
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let borderWidth: CGFloat = 0.5
        static let borderColor = Color.gray
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Avatar Section
            ZStack {
                Image(uiImage: avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Drawing.borderColor, lineWidth: Drawing.borderWidth)
                    )
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AvatarInCyrcleView(avatar: UIImage(named: "stephen")!)
}
