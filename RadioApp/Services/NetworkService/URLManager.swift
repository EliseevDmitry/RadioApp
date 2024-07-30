//
//  URLManager.swift
//  RadioApp
//
//  Created by Evgeniy K on 29.07.2024.
//

import Foundation

class URLManager {

    static let shared = URLManager()
    private init() {}

    // MARK: - get URL for Top stations
    func createURL(numberLimit: Int) -> URL? {
        URL(string: "http://at1.api.radio-browser.info/json/stations/topvote/" + "\(numberLimit)")
    }

    // MARK: - get URL for station by StationUUID
    func createURL(id: String) -> URL? {
        URL(string: "http://at1.api.radio-browser.info/json/stations/byuuid/" + id)
    }


}
