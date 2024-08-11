//
//  BackgroundApp.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 02.08.2024.
//


import SwiftUI

// MARK: - Background Type Enum
enum ScreenType {
    case profile
    case authentication
}

struct AnimatedBackgroundView: View {
    
    @State private var animate = false
    
    
    let screenType: ScreenType
    
    var body: some View {
        ZStack {
            DS.Colors.darkBlue
                .ignoresSafeArea()
            
            ForEach(0..<5, id: \.self) { index in
                BlobView(screenType: screenType)
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

// MARK: - BlobView
struct BlobView: View {
    
    let screenType: ScreenType

    
    // MARK: - Body
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: screenType == .profile ? Gradient(colors: [DS.Colors.pinkNeon, DS.Colors.blueNeon]) : Gradient(colors: [DS.Colors.pinkNeon, DS.Colors.darkBlue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .blur(radius: 50)
    }
}

// MARK: - BlobModifier
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
    AnimatedBackgroundView(screenType: .authentication)
}
