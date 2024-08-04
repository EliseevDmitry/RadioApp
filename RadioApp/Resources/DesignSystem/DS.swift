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
        //
        static let frame = Color(hex: "#32324E")

        /// серый - текст, неактивный ТабБар
        static let grayNotActive = Color(hex: "#4D4D6A")
        /// серый, SearchView
        static let graySearch = Color(hex: "#525270")
        /// серый, SearchViewImage
        static let graySearchImage = Color(hex: "#1F1D2B")
        /// розовый, PlayingNow
        static let pinkPlaying = Color(hex: "#B02854")


    }
    
    enum Fonts: String {
        case sfBold = "SFProDisplay-Bold"
        case sfMedium = "SFProDisplay-Medium"
        case sfRegular = "SFProDisplay-Regular"
        case sfSemibold = "SFProDisplay-Semibold"
    }
}
