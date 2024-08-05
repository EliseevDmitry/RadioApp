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
    func createURLTop(numberLimit: Int) -> URL? {
        URL(string: "http://at1.api.radio-browser.info/json/stations/topvote/" + "\(numberLimit)")
    }

    // MARK: - get URL for All stations
    func createURLAll() -> URL? {
        URL(string: "http://all.api.radio-browser.info/json/stations?limit=100")
    }

    // MARK: - get URL for station by StationUUID
    func createURLUUID(id: String) -> URL? {
        URL(string: "http://all.api.radio-browser.info/json/stations/byuuid/" + id)
        //9616a843-0601-11e8-ae97-52543be04c81
    }

    // MARK: - get URL to vote for station
    func createURLVote(id: String) -> URL? {
        URL(string: "http://all.api.radio-browser.info/json/vote/" + id)
    }

    // MARK: - get URL for search
    func createURLSearch(searchText: String) -> URL? {
        URL(string: "http://all.api.radio-browser.info/json/stations/search?name=" + searchText)
    }
    
}

