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
        VStack {
            Button(action: onTakePhoto) {
                Text("Take Photo")
                    .padding()
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
    }
}


#Preview {
    ChangePhotoView(onTakePhoto: {}, onChoosePhoto: {}, onDeletePhoto: {})
}
