//
//  TestAuthView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 02.08.2024.
//

import SwiftUI
import FirebaseAuth

struct TestAuthView: View {
    @EnvironmentObject var appManager: ViewModel
    
    var body: some View {

        Button("Sign Up") {
            
            appManager.registerUser()
            print("+++")
            
            
        }
    }
}

#Preview {
    TestAuthView()
}
