//
//  SplineView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 31.07.2024.
//

import SwiftUI


struct SplineViewShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00308*width, y: 0.33542*height))
        path.addCurve(to: CGPoint(x: 0.01754*width, y: 0.25004*height), control1: CGPoint(x: 0.00308*width, y: 0.27412*height), control2: CGPoint(x: 0.00944*width, y: 0.25004*height))
        path.addCurve(to: CGPoint(x: 0.09043*width, y: 0.47332*height), control1: CGPoint(x: 0.0563*width, y: 0.25004*height), control2: CGPoint(x: 0.07423*width, y: 0.36825*height))
        path.addCurve(to: CGPoint(x: 0.13844*width, y: 0.64407*height), control1: CGPoint(x: 0.10663*width, y: 0.5784*height), control2: CGPoint(x: 0.1182*width, y: 0.64407*height))
        path.addCurve(to: CGPoint(x: 0.1853*width, y: 0.36387*height), control1: CGPoint(x: 0.15869*width, y: 0.64407*height), control2: CGPoint(x: 0.17257*width, y: 0.49521*height))
        path.addCurve(to: CGPoint(x: 0.25934*width, y: 0.00925*height), control1: CGPoint(x: 0.20208*width, y: 0.19094*height), control2: CGPoint(x: 0.21885*width, y: 0.00925*height))
        path.addCurve(to: CGPoint(x: 0.33339*width, y: 0.36387*height), control1: CGPoint(x: 0.29984*width, y: 0.00925*height), control2: CGPoint(x: 0.31661*width, y: 0.18875*height))
        path.addCurve(to: CGPoint(x: 0.38025*width, y: 0.64407*height), control1: CGPoint(x: 0.34612*width, y: 0.49521*height), control2: CGPoint(x: 0.36*width, y: 0.64407*height))
        path.addCurve(to: CGPoint(x: 0.42826*width, y: 0.47332*height), control1: CGPoint(x: 0.40049*width, y: 0.64407*height), control2: CGPoint(x: 0.41206*width, y: 0.58059*height))
        path.addCurve(to: CGPoint(x: 0.50115*width, y: 0.25004*height), control1: CGPoint(x: 0.44446*width, y: 0.36825*height), control2: CGPoint(x: 0.46297*width, y: 0.25004*height))
        path.addCurve(to: CGPoint(x: 0.57519*width, y: 0.60467*height), control1: CGPoint(x: 0.54164*width, y: 0.25004*height), control2: CGPoint(x: 0.55841*width, y: 0.42954*height))
        path.addCurve(to: CGPoint(x: 0.62205*width, y: 0.88486*height), control1: CGPoint(x: 0.58792*width, y: 0.736*height), control2: CGPoint(x: 0.6018*width, y: 0.88486*height))
        path.addCurve(to: CGPoint(x: 0.6689*width, y: 0.60467*height), control1: CGPoint(x: 0.64229*width, y: 0.88486*height), control2: CGPoint(x: 0.65618*width, y: 0.736*height))
        path.addCurve(to: CGPoint(x: 0.74295*width, y: 0.25004*height), control1: CGPoint(x: 0.68568*width, y: 0.43173*height), control2: CGPoint(x: 0.70246*width, y: 0.25004*height))
        path.addCurve(to: CGPoint(x: 0.81584*width, y: 0.47332*height), control1: CGPoint(x: 0.78171*width, y: 0.25004*height), control2: CGPoint(x: 0.79964*width, y: 0.36825*height))
        path.addCurve(to: CGPoint(x: 0.86385*width, y: 0.64407*height), control1: CGPoint(x: 0.83203*width, y: 0.5784*height), control2: CGPoint(x: 0.8436*width, y: 0.64407*height))
        path.addCurve(to: CGPoint(x: 0.91186*width, y: 0.47332*height), control1: CGPoint(x: 0.8841*width, y: 0.64407*height), control2: CGPoint(x: 0.89566*width, y: 0.58059*height))
        path.addCurve(to: CGPoint(x: 0.98475*width, y: 0.25004*height), control1: CGPoint(x: 0.92806*width, y: 0.36825*height), control2: CGPoint(x: 0.94657*width, y: 0.25004*height))
        path.addCurve(to: CGPoint(x: 0.99921*width, y: 0.30477*height), control1: CGPoint(x: 0.99285*width, y: 0.25004*height), control2: CGPoint(x: 0.99921*width, y: 0.27412*height))
        return path
    }
}

struct PointOneView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addArc(center: CGPoint(x: 0.00308*width, y: 0.33542*height), radius: 15, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        return path
    }
}

struct PointTwoView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addArc(center: CGPoint(x: 0.99921*width, y: 0.30477*height), radius: 15, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        return path
    }
}

struct SplineView: View {
    @State private var startAnimation = false
    @State private var startTwoAnimation = false
    var body: some View {
        ZStack{
            SplineViewShape()
                .trim(from:0, to: startAnimation ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: 5))
                .fill(LinearGradient(colors: [.red, .green], startPoint: .leading, endPoint: .trailing))
            PointOneView()
                .fill(.red)
            PointTwoView()
                .fill(.green)
                .opacity(startAnimation ? 1 : 0)
        }
        .frame(width: .infinity, height: 100)
        .padding(.horizontal)
        .onAppear{
            withAnimation(.easeInOut(duration: 1).delay(0).repeatForever()) {
                startAnimation.toggle()
            }
        }
    }
}

#Preview {
    SplineView()
}
