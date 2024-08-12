//
//  SecureFieldForInvisiblePasswordView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 11.08.2024.
//

import SwiftUI

struct SecureFieldForInvisiblePasswordView: View {
    @ObservedObject var appManager: ViewModel
    
    var body: some View {
        SecureField(Resources.Text.yourPassword, text: $appManager.password, prompt: Text(Resources.Text.yourPassword).foregroundColor(.gray))
            .font(.title3)
            .foregroundStyle(.white)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(DS.Colors.pinkNeon, lineWidth: 2).shadow(color: DS.Colors.pinkNeon, radius: 3)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .tint(DS.Colors.pinkNeon)
    }
}


#Preview {
    SecureFieldForInvisiblePasswordView(appManager: ViewModel())
}
