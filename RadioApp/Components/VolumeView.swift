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
    @Binding var voulmeGeometry: CGFloat
    var body: some View {
        VStack{
            Text("\((Int(voulmeGeometry*100)).formatted())%")
                .font(.system(size: 12))
                .foregroundStyle(.white)
            GeometryReader { screen in
                ZStack{
                    ZStack(alignment: .bottom){
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(DS.Colors.frame)
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(DS.Colors.blueNeon)
                            .frame(height: (screen.size.height * CGFloat(self.voulmeGeometry)))
                    }
                    .frame(width: 4)
                    Circle()
                        .foregroundStyle(DS.Colors.blueNeon)
                        .position(CGPoint(x: 5.0, y: screen.size.height - (screen.size.height * CGFloat(self.voulmeGeometry)) ))
                        .frame(width: 10)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    withAnimation(.linear(duration: 2)){
                                        if voulmeGeometry >= 0 && voulmeGeometry <= 1 {
                                            voulmeGeometry -= CGFloat(Float((value.translation.height/screen.size.height/80)))
                                            appManager.setVolme()
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    if voulmeGeometry >= 1 {
                                        voulmeGeometry = 1
                                    } else if voulmeGeometry <= 0 {
                                        voulmeGeometry = 0
                                    }
                                    appManager.setVolme()
                                })
                               
                        )
                       
                }
            }
            .frame(width: 10)
            Image(systemName: voulmeGeometry == 0 ? "speaker.slash" : "speaker.wave.2")
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
