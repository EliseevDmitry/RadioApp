//
//  CustomTextField.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 01.08.2024.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var value: String
    var placeHolder: String
    var titleBorder: String
    
    var body: some View {
        
        TextField(placeHolder,
                  text: $value)
        .padding(.leading, 16)
        .foregroundStyle(.white)
        .padding(.vertical, 16)
        .disableAutocorrection(true)
        .overlay {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        value.isEmpty
                        ? DS.Colors.darkBlue
                        : Color.gray, lineWidth: 1.0
                    )
                    .opacity(0.3)
                Text(titleBorder)
                    .foregroundStyle(.white)
                    .font(.custom(.sfSemibold, size: 12))
                    .offset(x: -128, y: -20)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    CustomTextField(
        value: .constant("Value"),
        placeHolder: "email",
        titleBorder: "email")
}
