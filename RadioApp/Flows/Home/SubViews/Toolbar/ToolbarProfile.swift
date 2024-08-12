//
//  ToolbarProfile.swift
//  RadioApp
//
//  Created by Evgeniy K on 07.08.2024.
//

import SwiftUI

struct UserIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.76179*width, y: 0.66313*height))
        path.addCurve(to: CGPoint(x: 0.76179*width, y: 0.33786*height), control1: CGPoint(x: 0.93222*width, y: 0.58821*height), control2: CGPoint(x: 0.93222*width, y: 0.41278*height))
        path.addLine(to: CGPoint(x: 0.52988*width, y: 0.23593*height))
        path.addCurve(to: CGPoint(x: 0.116*width, y: 0.39854*height), control1: CGPoint(x: 0.34951*width, y: 0.15658*height), control2: CGPoint(x: 0.116*width, y: 0.24833*height))
        path.addLine(to: CGPoint(x: 0.116*width, y: 0.60245*height))
        path.addCurve(to: CGPoint(x: 0.52988*width, y: 0.76506*height), control1: CGPoint(x: 0.116*width, y: 0.75266*height), control2: CGPoint(x: 0.34951*width, y: 0.84441*height))
        path.addLine(to: CGPoint(x: 0.76179*width, y: 0.66313*height))
        path.closeSubpath()
        return path
    }
}

struct ToolbarProfile: View {
    @EnvironmentObject var appManager: HomeViewModel
    var toolbarRoute: () -> ()
    
    var body: some View {
           Button(action: {
               toolbarRoute()
           }) {
               Image(uiImage: appManager.userProfileImage ?? .eliseev)
                   .resizable()
                   .scaledToFit()
                   .frame(width: 60, height: 70)
                   .mask {
                       UserIcon()
                           .frame(width: 60, height: 70)
                   }
           }
       }
   }


//#Preview {
//    ToolbarProfile()
//        .environmentObject(ViewModel())
//}
