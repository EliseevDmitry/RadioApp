//
//  BackgroundApp.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 02.08.2024.
//


import SwiftUI

struct AnimatedBackgroundView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            DS.Colors.darkBlue
                .ignoresSafeArea()
            
            ForEach(0..<5, id: \.self) { index in
                BlobView()
                    .frame(width: 200, height: 200)
                    .modifier(BlobModifier(animate: $animate))
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 5...10))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...3)),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

struct BlobView: View {
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [DS.Colors.pinkNeon, DS.Colors.blueNeon]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .blur(radius: 50)
    }
}

struct BlobModifier: ViewModifier {
    @Binding var animate: Bool
    
    func body(content: Content) -> some View {
        content
            .offset(
                x: animate ? CGFloat.random(in: -200...200) : 0,
                y: animate ? CGFloat.random(in: -400...400) : 0
            )
    }
}

// MARK: - Preview
#Preview {
    AnimatedBackgroundView()
}
