//
//  TestRotationView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 09.08.2024.
//

import SwiftUI

struct TestRotationView: View {
    var appManager: ViewModel
    var body: some View {
        VStack{
            VolumeView(appManager: appManager, rotation: true)
                .frame(height: 200)
            //.preferredColorScheme(.dark)
            //так как у нас компонент идет через rotationEffect
            //его width задается через .frame(height: 200)
            RoundedRectangle(cornerRadius: 20)
                .fill(.orange)
                .frame(width: 200,height: 200)
                .onTapGesture {
                    print("tap")
                }
                .onLongPressGesture {
                    print("long tap")
                }
        }
    }
}

//MARK: - PREVIEW
//struct TestRotationView_Previews: PreviewProvider {
//    static let previewAppManager = ViewModel()
//    static var previews: some View {
//        TestRotationView()
//            .environmentObject(previewAppManager)
//    }
//}
