//
//  Button + Extension.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 11.08.2024.
//

import SwiftUI

extension Button {
    /// Инициализатор для создания кнопки с асинхронным действием.
    /// - Parameters:
    ///   - asyncAction: Асинхронное действие, которое будет выполнено при нажатии на кнопку.
    ///   - label: Вью для отображения содержимого кнопки.
    init(
        asyncAction: @escaping @Sendable () async -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.init(
            // Вызов асинхронного действия с высоким приоритетом при нажатии на кнопку
            action: { Task(priority: .high, operation: asyncAction) },
            label: label
        )
    }
}
