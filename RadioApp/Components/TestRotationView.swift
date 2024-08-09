//
//  TestRotationView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 09.08.2024.
//

import SwiftUI

struct TestRotationView: View {
    var body: some View {
        VolumeView(rotation: true)
            .frame(height: 200)
            .preferredColorScheme(.dark)
        //так как у нас компонент идет через rotationEffect
        //его width задается через .frame(height: 200)
    }
}

//MARK: - PREVIEW
struct TestRotationView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        TestRotationView()
            .environmentObject(previewAppManager)
    }
}
