//
//  VolumeView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI
import MediaPlayer

struct VolumeView: View {
    @EnvironmentObject var appManager: ViewModel
    var body: some View {
        VStack{
            Text("\((Int(appManager.volume*100)).formatted())%")
                .font(.system(size: 12))
                .foregroundStyle(.white)
            GeometryReader { screen in
                ZStack{
                    ZStack(alignment: .bottom){
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(DS.Colors.frame)
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(DS.Colors.blueNeon)
                            .frame(height: (screen.size.height * CGFloat(self.appManager.volume)))
                    }
                    .frame(width: 4)
                    Circle()
                        .foregroundStyle(DS.Colors.blueNeon)
                        .position(CGPoint(x: 5.0, y: screen.size.height - (screen.size.height * CGFloat(self.appManager.volume)) ))
                        .frame(width: 10)
                    //запретили менять - только показывать!
//                        .gesture(
//                            DragGesture()
//                                .onChanged({ value in
//                                    withAnimation(.linear(duration: 2)){
//                                        if appManager.volume >= 0 && appManager.volume <= 1 {
//                                            appManager.volume -= CGFloat(Float((value.translation.height/screen.size.height/50)))
//                                            appManager.setVolme()
//                                           
//                                        }
//                                    }
//                                })
//                                .onEnded({ _ in
//                                    if appManager.volume >= 1 {
//                                        appManager.volume = 1
//                                    } else if appManager.volume <= 0 {
//                                        appManager.volume = 0
//                                    }
//                                    appManager.setVolme()
//                                    
//                                })
//                        )
                }
            }
            .frame(width: 10)
            Image(systemName: appManager.volume == 0 ? "speaker.slash" : "speaker.wave.2")
                .resizable()
                .offset(CGSize(width: 5.0, height: 5.0))
                .frame(width: 18, height: 18)
                .foregroundStyle(DS.Colors.frame)
        }
    }
    
    
}

//MARK: - PREVIEW
//struct VolumeView_Previews: PreviewProvider {
//    static let previewAppManager = ViewModel()
//    static var previews: some View {
//        VolumeView(voulmeValue: .constant(0.5))
//            .environmentObject(previewAppManager)
//    }
//}
