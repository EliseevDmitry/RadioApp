//
//  ChangedPhotoView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 02.08.2024.
//

import SwiftUI

struct ChangePhotoView: View {
    // MARK: - Properties
    var onTakePhoto: () -> Void
    var onChoosePhoto: () -> Void
    var onDeletePhoto: () -> Void
    
    // MARK: - Body
    var body: some View {
        ZStack {
            AnimatedBackgroundView(screenType: .profile)
                
            VStack(alignment: .leading) {
                // MARK: - Take Photo Button
                EditPhotoButtonView(
                    title: Resources.Text.takePhoto,
                    image: Resources.Image.photoIcon,
                    action: onTakePhoto
                )
                    
                Divider()
                
                // MARK: - Choose Photo Button
                EditPhotoButtonView(
                    title: Resources.Text.choosePhoto,
                    image: Resources.Image.fileIcon,
                    action: onChoosePhoto
                )

                Divider()
                
                // MARK: - Delete Photo Button
                EditPhotoButtonView(
                    title: Resources.Text.deletePhoto,
                    image: Resources.Image.noPhoto,
                    action: onDeletePhoto
                )
            }
            .font(.custom(.sfBold, size: 18))
            .foregroundColor(DS.Colors.blueNeon)
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    ChangePhotoView(onTakePhoto: {}, onChoosePhoto: {}, onDeletePhoto: {})
}
