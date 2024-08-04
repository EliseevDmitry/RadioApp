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
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
                
            VStack {
                EditPhotoButttonView(
                    title: Resources.Text.takePhoto,
                    image: Resources.Image.photoIcon,
                    action: onTakePhoto)
                    
                Divider()
                
                EditPhotoButttonView(
                    title: Resources.Text.choosePhoto,
                    image: Resources.Image.fileIcon,
                    action: onChoosePhoto
                )

                Divider()
                
                EditPhotoButttonView(
                    title: Resources.Text.deletePhoto,
                    image: Resources.Image.noPhoto,
                    action: onDeletePhoto
                )
            }
            .font(.custom(.sfBold, size: 18))
            .foregroundColor(DS.Colors.blueNeon)
        }
    }
}


#Preview {
    ChangePhotoView(onTakePhoto: {}, onChoosePhoto: {}, onDeletePhoto: {})
}
