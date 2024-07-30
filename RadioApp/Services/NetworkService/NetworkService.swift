//
//  NetworkService.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.v
//

import Foundation

actor NetworkService {

    // MARK: - get top stations

    func getTopStations(numberLimit: Int) async throws -> [Station] {
        var stations = [Station]()

        guard let url = URLManager.shared.createURL(numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badResponse
        }

        guard let decodedStations = try? JSONDecoder().decode([Station].self, from: data) else {
            throw NetworkError.decodingError
        }

        stations = decodedStations
        return stations
    }

    // MARK: - get station by UUID

    func getStationById(id: String) async throws -> [Station] {
        var stationById = [Station]()

        guard let url = URLManager.shared.createURL(id: id) else {
            throw NetworkError.badURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badResponse
        }

        guard let decodedStation = try? JSONDecoder().decode([Station].self, from: data) else {
            throw NetworkError.decodingError
        }

        stationById = decodedStation
        return stationById
    }
}

// MARK: - network errors

enum NetworkError: Error {
    case badURL
    case badData
    case badResponse
    case decodingError
}

