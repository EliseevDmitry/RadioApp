//
//  DS.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 28.07.2024.
//

import SwiftUI

// MARK: - DS (Design System)
enum DS {
    enum Colors {
        /// темноСиний.
        static let darkBlue = Color(hex: "#01012A")
        /// бирюзовый
        static let turquoise = Color(hex: "#005679")
        /// голубойНеоновый.
        static let blueNeon = Color(hex: "#05D8E8")
        /// бледно голубой.
        static let blueLight = Color(hex: "#D1F9FF")
        /// розовыйНеоновый.
        static let pinkNeon = Color(hex: "#FF296D")
    }
    
    enum Fonts: String {
        case sfBold = "SF-Pro-Display-Bold"
        case sfMedium = "SF-Pro-Display-Medium"
        case sfRegular = "SF-Pro-Display-Regular"
        case sfSemibold = "SF-Pro-Display-Semibold"
    }
}
