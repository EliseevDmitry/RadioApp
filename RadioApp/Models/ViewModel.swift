//
//  ViewModel.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import Foundation

@MainActor
final class ViewModel: ObservableObject {

    @Published var stations = [Station]()
    // добавляем сюда другие @Published свойства

    let network = NetworkService()

    func fetchTopStations() async throws {
        var fetchedStations: [Station]
        fetchedStations = try await network.getTopStations(numberLimit: 15)
        stations = fetchedStations
    }
}
