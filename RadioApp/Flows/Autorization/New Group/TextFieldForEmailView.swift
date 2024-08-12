//
//  TextFieldForEmailView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 11.08.2024.
//

import SwiftUI

struct TextFieldForEmailView: View {
    @ObservedObject var appManager: ViewModel
    
    private struct DrawingConstants {
        static let verticalPaddingSize = UIScreen.height * 1/54
    }
    
    var body: some View {
        HStack {
            Text(Resources.Text.email)
                .foregroundStyle(.white)
                .padding(.vertical, DrawingConstants.verticalPaddingSize)
            Spacer()
        }
        TextField(Resources.Text.yourEmail, text: $appManager.email, prompt: Text(Resources.Text.yourEmail).foregroundColor(.gray))
            .font(.title3)
            .foregroundStyle(.white)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(DS.Colors.pinkNeon, lineWidth: 2).shadow(color: DS.Colors.pinkNeon, radius: 3)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .keyboardType(.emailAddress)
            .tint(DS.Colors.pinkNeon)
    }
}


#Preview {
    TextFieldForEmailView(appManager: ViewModel())
}
