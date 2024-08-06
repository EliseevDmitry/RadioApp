//
//  ChangedPhotoView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 02.08.2024.
//

import SwiftUI


struct ChangePhotoView: View {
    
    var onTakePhoto: () -> Void
    var onChoosePhoto: () -> Void
    var onDeletePhoto: () -> Void
    
    // MARK: - Drawing Constants
    private struct DrawingConstants {
        static let iconSize: CGFloat = 20
        static let iconPadding: CGFloat = 8
        static let textSize: CGFloat = 14
        static let buttonPadding: CGFloat = 10
        static let strokeWidth: CGFloat = 0.8
        static let cornerRadius: CGFloat = 10
    }
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView(screenType: .profile)
                
            VStack {
                HStack {
                    Button(action: onTakePhoto) {
                        Text("Take Photo")
                            .padding()
                    }
                    Image( Resources.Image.photoIcon)
                        .resizable()
                        .frame(
                            width: DrawingConstants.iconSize,
                            height: DrawingConstants.iconSize
                        )
                        .padding(.leading, DrawingConstants.iconPadding)
                    
                }
                Divider()
                Button(action: onChoosePhoto) {
                    Text("Choose Photo")
                        .padding()
                }
                Divider()
                Button(action: onDeletePhoto) {
                    Text("Delete Photo")
                        .padding()
                }
            }
            .font(.custom(.sfBold, size: 18))
            .foregroundColor(Color.white)
        }
    }
}


#Preview {
    ChangePhotoView(onTakePhoto: {}, onChoosePhoto: {}, onDeletePhoto: {})
}
