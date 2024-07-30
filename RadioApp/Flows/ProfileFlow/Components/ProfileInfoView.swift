//
//  ProfileInfoView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 30.07.2024.
//

import SwiftUI

struct ProfileInfoView: View {
    
    var userName: String
    var email: String
    var avatar: UIImage
    
    var body: some View {
        HStack {
            Image(uiImage: avatar)
                .resizable()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, 
                    style: FillStyle()
                )
                .frame(
                    width: 54,
                    height: 54
                )
                .padding(.leading, 16)
            
            VStack(
                alignment: .leading,
                spacing: 8
            )  {
                Text(userName)
                    .font(Font.custom( .sfMedium, size: 16))
                    .foregroundStyle(.white)
                
                Text(email)
                    .font(Font.custom(.sfMedium, size: 14))
                    .foregroundColor(Color.gray)
                
            }
            .padding(.leading, 8)
            
            Spacer()
            
        }
        .padding()
        .background(DS.Colors.darkBlue)
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1.0)
                .opacity(0.2)
        }
    }
}

#Preview {
    ProfileInfoView(
        userName: "ds",
        email: "ds@ds",
        avatar: UIImage(named: "stephen")!)
}


