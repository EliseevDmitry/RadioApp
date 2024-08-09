//
//  EqualizerView.swift
//  RadioApp
//
//  Created by Evgeniy K on 08.08.2024.
//

import SwiftUI

struct EqualizerView: View {

    @EnvironmentObject var appManager: ViewModel

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1 ..< 32, id: \.self) { column in
                let amplitudeModifier = appManager.amplitude * CGFloat(column) * 0.05
                let circleCount = max(1, Int(15 + amplitudeModifier))
                let yOffset = CGFloat(circleCount) * 2.5

                VStack {
                    ForEach(1 ..< circleCount, id: \.self) { _ in
                        Circle()
                            .foregroundStyle(DS.Colors.darkBlue)
                            .frame(width: 5, height: 5) // Задаем фиксированный размер кругов
                    }
                }
                .offset(y: -yOffset)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            appManager.playAudio(url: Station.testStation().url)
        }
    }
}

#Preview {
    EqualizerView()
        .environmentObject(ViewModel())
}
