//
//  VolumeView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI
import MediaPlayer

struct VolumeView: View {
    //MARK: - PROPERTIES
    @ObservedObject var appManager: ViewModel
    var rotation: Bool
    var body: some View {
        //MARK: - BODY
        VStack{
            Text("\((Int(appManager.volume*100)).formatted())%")
                .font(.system(size: 12))
                .foregroundStyle(.white)
                .rotationEffect(rotation ? -Angle(degrees: (90)) : Angle(degrees: 0))
                .offset(CGSize(width:0, height:rotation ? -12.0 : 0.0))
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
                }
            }
            .frame(width: 10)
            Image(systemName: appManager.volume == 0 ? "speaker.slash" : "speaker.wave.2")
                .resizable()
                .offset(CGSize(width:rotation ? 0 : 5.0, height:rotation ? 0 : 5.0))
                .frame(width: 18, height: 18)
                .foregroundStyle(DS.Colors.frame)
                .rotationEffect(rotation ? -Angle(degrees: (90)) : Angle(degrees: 0))
            
        }
        .rotationEffect(rotation ? Angle(degrees: (90)) : Angle(degrees: 0))
    }
}

//MARK: - PREVIEW
struct VolumeView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        VolumeView(appManager: previewAppManager, rotation: false)
    }
}
