//
//  EqualizerView.swift
//  RadioApp
//
//  Created by Evgeniy K on 08.08.2024.
//

import SwiftUI

import SwiftUI

struct EqualizerView: View {

    @EnvironmentObject var appManager: HomeViewModel
    @State private var phaseShift: Double = 0.0

    var body: some View {
            GeometryReader { geometry in
                HStack(spacing: 10) {
                    ForEach(1 ..< 33, id: \.self) { column in
                        let randomFactor = CGFloat.random(in: 0.5...1.5)
                        let amplitudeModifier = appManager.amplitude * randomFactor * CGFloat(column) * 0.5
                        let circleCount = max(1, min(40, Int(amplitudeModifier)))
                        
                        let xPosition = Double(column) / 6.0
                        
                        let yOffset = sin(xPosition + phaseShift + amplitudeModifier / 5) * geometry.size.height / 8
                        
                        VStack {
                            ForEach(0 ..< circleCount, id: \.self) { _ in
                                Circle()
                                    .foregroundStyle(DS.Colors.pinkNeon)
                                    .frame(width: 4, height: 4)
                            }
                        }
                        .offset(y: yOffset)
                    }
                }
            .frame(maxWidth: 300, maxHeight: 300)
            .onAppear {
                //appManager.playAudio(url: Station.testStation().url)

                // Cкорость движения синусоиды
                Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
                    withAnimation(.spring(duration: 0.2).delay(0.09)) {
                        // Фазы для замедления синусоиды
                        phaseShift += 0.03
                    }
                }
            }
        }
    }
}

#Preview {
    EqualizerView()
        .environmentObject(HomeViewModel())
}
