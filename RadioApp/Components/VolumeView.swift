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
            Text("\((Int(voulmeValue*100)).formatted())%")
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
                    }
                    .frame(width: 10)
                    Circle()
                        .foregroundStyle(DS.Colors.blueNeon)
                        .position(CGPoint(x: 10.0, y: screen.size.height - (screen.size.height * CGFloat(self.voulmeValue)) ))
                        .frame(width: 20)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    withAnimation(.linear(duration: 2)){
                                        if voulmeValue >= 0 && voulmeValue <= 1 {
                                            voulmeValue -= (value.translation.height/screen.size.height/80)
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    if voulmeValue >= 1 {
                                        voulmeValue = 1
                                    } else if voulmeValue <= 0 {
                                        voulmeValue = 0
                                    }
                                })
                        )
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
    VolumeView(voulmeValue: .constant(0.4))
}
