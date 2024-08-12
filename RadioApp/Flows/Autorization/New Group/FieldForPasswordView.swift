//
//  FieldForPasswordView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 11.08.2024.
//

import SwiftUI

struct FieldForPasswordView: View {
    //MARK: - PROPERTIES
    @ObservedObject var appManager: ViewModel
    @State private var isPasswordVisible = false
    private struct DrawingConstants {
        static let verticalPaddingSize = UIScreen.height * 1/108
    }
    //MARK: - BODY
    var body: some View {
        HStack {
            Text(Resources.Text.password)
                .foregroundStyle(.white)
                .padding(.vertical, DrawingConstants.verticalPaddingSize)
            Spacer()
        }
        ZStack {
            if isPasswordVisible {
                TextFieldForVisiblePasswordView(appManager: appManager)
            } else {
                SecureFieldForInvisiblePasswordView(appManager: appManager)
            }
            HStack {
                Spacer()
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .resizable()
                        .frame(width: 24, height: 18)
                        .scaledToFit()
                }
                .foregroundColor(.gray)
                .padding(.trailing)
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    FieldForPasswordView(appManager: ViewModel())
}
