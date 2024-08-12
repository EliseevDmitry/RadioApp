//
//  CustomTextField.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 01.08.2024.
//

import SwiftUI

//MARK: - CustomTextField
struct CustomTextField: View {
    // MARK: - Properties
    @Binding var value: String
    var placeHolder: String
    var titleBorder: String
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let leadingPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let strokeWidth: CGFloat = 1.0
        static let strokeOpacity: CGFloat = 0.3
        static let titleFontSize: CGFloat = 18
        static let titleOffsetX: CGFloat = -128
        static let titleOffsetY: CGFloat = -28
        static let borderColor = DS.Colors.pinkNeon
        static let textColor = Color.white
        static let filledBorderColor = Color.gray
        static let backgroundWidth: CGFloat = 100
        static let backgroundHeight: CGFloat = 20
        static let backgroundColor = Color.clear
    }
    
    // MARK: - Body
    var body: some View {
        TextField(
            placeHolder,
            text: $value
        )
        .padding(.leading, Drawing.leadingPadding)
        .padding(.vertical, Drawing.verticalPadding)
        .foregroundStyle(Drawing.textColor)
        .disableAutocorrection(true)
        .overlay {
            ZStack {
                RoundedRectangle(cornerRadius: Drawing.cornerRadius)
                    .stroke(
                        value.isEmpty ? Drawing.borderColor : Drawing.filledBorderColor,
                        lineWidth: Drawing.strokeWidth
                    )
                    .opacity(Drawing.strokeOpacity)
                ZStack {
                    Drawing.backgroundColor
                        .frame(
                            width: Drawing.backgroundWidth,
                            height: Drawing.backgroundHeight
                        )
                        .cornerRadius(Drawing.cornerRadius)
                        .offset(
                            x: Drawing.titleOffsetX,
                            y: Drawing.titleOffsetY
                        )
                    Text(titleBorder.capitalized)
                        .foregroundStyle(Drawing.textColor)
                        .font(.custom(.sfBold, size: Drawing.titleFontSize))
                        .offset(
                            x: Drawing.titleOffsetX,
                            y: Drawing.titleOffsetY
                        )
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CustomTextField(
        value: .constant("Value"),
        placeHolder: "email",
        titleBorder: "email"
    )
}
