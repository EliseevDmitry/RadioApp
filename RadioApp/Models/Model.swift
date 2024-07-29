//
//  Model.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import Foundation

struct Station: Codable {

    let changeuuid: String
    let stationuuid: String
    let serveruuid: String?
    let name: String

    //url for audio
    let url: String
    let url_resolved: String
    let homepage: String
    let favicon: String
    let tags: String
    let country: String
    let countrycode: String

//    let iso3166_2: String?

    let state: String
    let language: String
    let languagecodes: String
    let votes: Int

//    let lastchangetime: String
//    let lastchangetime_iso8601: String

    let codec: String
    let bitrate: Int
    let hls: Int
    let lastcheckok: Int

//    let lastchecktime: String
//    let lastchecktime_iso8601: String
//    let lastcheckoktime: String
//    let lastcheckoktime_iso8601: String
//    let lastlocalchecktime: String
//    let lastlocalchecktime_iso8601: String?
//    let clicktimestamp: String
//    let clicktimestamp_iso8601: String

}
