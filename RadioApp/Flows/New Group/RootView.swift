//
//  RootView.swift
//  RadioApp
//
//  Created by Денис Гиндулин on 08.08.2024.
//

import SwiftUI

// MARK: - RootView
struct RootView: View {
    // MARK: - Properties
    @EnvironmentObject var appManager: ViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                WelcomeView()
                    .environmentObject(appManager)
                    .environment(\.managedObjectContext, appManager.container.viewContext)
            }
        }
        // здесь происходит проверка в синхронном режиме прошел ли пользователь аутентификацию. Если нет, то будет открыт экран SignInView, если да, то экран PopularView. Точнее, здесь в зависимости от обнаружения аутентифицированного пользователя присаивается значение значение свойству showSignInView
        .onAppear {
            let authenticatedUser = try? AuthManager.shared.getAuthenticatedUser()
            appManager.showSignInView = authenticatedUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $appManager.showSignInView) {
            NavigationView {
                SignInView()
                    .environmentObject(appManager)
                    .environment(\.managedObjectContext, appManager.container.viewContext)
            }
            
        }
        /*
        NavigationView {
            SignInView()
        }
        .navigationViewStyle(.stack)
        */
    }
}

//#Preview {
//    RootView()
//}


struct RootView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    
    static var previews: some View {
        RootView()
            .environmentObject(previewAppManager)
    }
}
