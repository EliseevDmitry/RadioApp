//
//  EqualizerService.swift
//  RadioApp
//
//  Created by Evgeniy K on 09.08.2024.
//

import Foundation
import AVFoundation
import Combine

final class EqualizerService {

    private var audioPlayer: AVPlayer?
    private var cancellables = Set<AnyCancellable>()

    @Published var amplitude: CGFloat = 0.0

    func playAudio(url: URL) {
        // Инициализация AVPlayer с URL
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)

        // Добавляем наблюдателя за амплитудой аудиосигнала
        let audioOutput = AVPlayerItemOutput()
        playerItem.add(audioOutput)

        // Подписка на периодические обновления
        audioPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 60), queue: .main) { [weak self] time in
            self?.analyzeAudio()
        }

        // Начинаем воспроизведение
        audioPlayer?.play()
    }

    func stopAudio() {
        audioPlayer?.pause()
        audioPlayer = nil
    }

    private func analyzeAudio() {
        // Пример расчета амплитуды — реальный расчет зависит от требований к эквалайзеру
        // Здесь вы можете добавить реальную обработку аудио данных
        // Например, можно получить текущий уровень громкости и на его основе менять значение amplitude

        // Здесь просто добавляем примерную логику для генерации данных амплитуды
        amplitude = CGFloat(drand48()) * 2.0 // Замените на реальный расчет амплитуды
    }
}
