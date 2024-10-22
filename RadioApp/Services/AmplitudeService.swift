//
//  AmplitudeService.swift
//  RadioApp
//
//  Created by Evgeniy K on 09.08.2024.
//

import Foundation
import Combine

class AmplitudeService {
    //MARK: - PROPERTIES
    private var timer: AnyCancellable?
    private let updateInterval: TimeInterval = 0.08
    
    //MARK: - Methods
    func startUpdatingAmplitude(viewModel: ViewModel) {
        timer = Timer.publish(every: updateInterval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                Task { @MainActor in
                    // Схематическое обновление амплитуды
                    viewModel.amplitude = CGFloat.random(in: 0...1)
                }
            }
    }

    func stopUpdatingAmplitude() {
        timer?.cancel()
    }
}
