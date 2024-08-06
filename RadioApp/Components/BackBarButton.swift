//
//  BackBarButton.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

// MARK: - BackBarButton
struct BackBarButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: Resources.Image.arrowLeft)
                .foregroundColor(.primary)
        }
    }
}
