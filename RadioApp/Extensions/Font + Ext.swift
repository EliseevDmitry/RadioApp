//
//  Font + Ext.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 29.07.2024.
//

import SwiftUI

extension Font {
    static func custom(_ nameFont: DS.Fonts, size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(nameFont.rawValue, size: size)
    }
}
