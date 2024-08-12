//
//  ToolbarView.swift
//  RadioApp
//
//  Created by Evgeniy K on 07.08.2024.
//

import SwiftUI

struct ToolbarName: View {
    
    @EnvironmentObject var appManager: HomeViewModel
    
    var body: some View {
        
        HStack {
            Image(.toolbarplay)
            //.padding(.leading, 10)
            
            Text("Hello")
                .foregroundStyle(.white)
                .font(.custom(DS.Fonts.sfMedium, size: 25))
            
            //@Published var username = "Mark" - наблюдаемое свойство имени
            Text("\(appManager.username)")
                .foregroundStyle(DS.Colors.pinkNeon)
                .font(.custom(DS.Fonts.sfMedium, size: 25))
            
            Spacer()
        }
        .padding(.leading, 10)
        .padding(.vertical, 20)
        
    }
}

#Preview {
    ContentView()
        .environmentObject(HomeViewModel())
}
