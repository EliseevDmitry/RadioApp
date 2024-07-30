//
//  VolumeView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct VolumeView: View {
    @Binding var voulmeValue: CGFloat
    var body: some View {
        VStack{
            Text("\((voulmeValue*100).formatted())%")
                .font(.system(size: 20))
                .foregroundStyle(.black)
            GeometryReader { screen in
                ZStack{
                    ZStack(alignment: .bottom){
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(DS.Colors.darkBlue)
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(DS.Colors.blueNeon)
                            .frame(height: (screen.size.height * CGFloat(self.voulmeValue)))
                        
                        
                    }//: ZSTACK ProgressBar
                    .frame(width: 10)
                        Circle()
                            .foregroundStyle(DS.Colors.blueNeon)
                            .position(CGPoint(x: 10.0, y: screen.size.height - (screen.size.height * CGFloat(self.voulmeValue)) ))
                            .frame(width: 20)
                }
            }
            .frame(width: 10)
            Image(systemName: voulmeValue == 0 ? "speaker.slash" : "speaker.wave.2")
                .resizable()
                .offset(CGSize(width: 5.0, height: 5.0))
                .frame(width: 30, height: 30)
        }
    }
}

#Preview {
    VolumeView(voulmeValue: .constant(0.1))
}
