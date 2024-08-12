//
//  TextFieldForNameView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 11.08.2024.
//

import SwiftUI

struct TextFieldForNameView: View {
    //MARK: - PROPERTIES
    @ObservedObject var appManager: ViewModel
    private struct DrawingConstants {
        static let verticalPaddingSize = UIScreen.height * 1/108
    }
    
    //MARK: - BODY
    var body: some View {
        HStack {
            Text(Resources.Text.name)
                .foregroundStyle(.white)
                .padding(.vertical, DrawingConstants.verticalPaddingSize)
            Spacer()
        }
        TextField(Resources.Text.yourName, text: $appManager.username, prompt: Text(Resources.Text.yourName).foregroundColor(.gray))
            .font(.title3)
            .foregroundStyle(.primary)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(DS.Colors.pinkNeon, lineWidth: 2)
                    .shadow(color: DS.Colors.pinkNeon, radius: 3)
            }
            .autocorrectionDisabled()
            .tint(DS.Colors.pinkNeon)
    }
}

//MARK: - PREVIEW
#Preview {
    TextFieldForNameView(appManager: ViewModel())
}
