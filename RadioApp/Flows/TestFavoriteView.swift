//
//  TestFavoriteView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 04.08.2024.
//

import SwiftUI

struct TestFavoriteView: View {
    var body: some View {
        @EnvironmentObject var appManager: ViewModel
        var favoriteStations = [Station]()
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear{
            appManager.loadLikesData()
        }

    }
        
}

#Preview {
    TestFavoriteView()
}
