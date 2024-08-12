//
//  Model.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import Foundation

// MARK: - JSON Model
struct Station: Codable, Hashable {
    let stationuuid: String
    let name: String
    let url: String
    let favicon: String
    let tags: String
    let countrycode: String
    var votes: Int32
    
    //---reserv request data---
    //let changeuuid: String
    //let serveruuid: String?
    //let homepage: String
    //let url_resolved: String
    //let country: String
    //let iso3166_2: String?
    //let state: String
    //let language: String
    //let languagecodes: String
    //let lastchangetime: String
    //let lastchangetime_iso8601: String
    //let codec: String
    //let bitrate: Int
    //let hls: Int
    //let lastcheckok: Int
    //let lastchecktime: String
    //let lastchecktime_iso8601: String
    //let lastcheckoktime: String
    //let lastcheckoktime_iso8601: String
    //let lastlocalchecktime: String
    //let lastlocalchecktime_iso8601: String?
    //let clicktimestamp: String
    //let clicktimestamp_iso8601: String
}

//MARK: - unique IDs
struct Like: Codable {
    var idUUID = UUID()
    var likeSet: Set<String>
}

//MARK: - UserModel
struct UserModel: Identifiable, Codable {
    let id: String
    let userName: String
    let email: String
    var profileImage: String?
}

// MARK: - Preview data
extension Station {
    static func testStation() -> Station {
        let station = Station(
            stationuuid: "9617a958-0601-11e8-ae97-52543be04c81",
            name: "Radio Paradise (320k)",
            // url for streaming data
            url: "http://stream-uk1.radioparadise.com/aac-320",
            favicon: "https://www.radioparadise.com/favicon-32x32.png",
            tags: "california,eclectic,free,internet,non-commercial,paradise,radio",
            countrycode: "US",
            votes: 201303
            
            //---reserv request data---
            //codec: "AAC",
            //bitrate: 320,
            //hls: 0,
            //lastcheckok: 1
            //state: "California",
            //language: "english",
            //languagecodes: "",
            //country: "The United States Of America",
            //url_resolved: "http://stream-uk1.radioparadise.com/aac-320",
            //homepage: "https://www.radioparadise.com/",
            //serveruuid: nil,
            //changeuuid: "8125d095-6397-4660-a5c4-ef0254f67e06",
        )
        return station
    }
}
