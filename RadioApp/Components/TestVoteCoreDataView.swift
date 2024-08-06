//
//  TestVoteCoreDataView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 04.08.2024.
//

import SwiftUI

//struct StationD {
//    var stationuuid: String
//    var url: String
//    var name: String
//    var countrycode: String
//    var voites: Int16
//}

struct TestVoteCoreDataView: View {
    @EnvironmentObject var appManager: ViewModel
    @FetchRequest(sortDescriptors: []) var stationData: FetchedResults<StationData>
    var body: some View {
        VStack{
            List(stationData) {dataSt in
                Text("\(String(describing: dataSt.name)) + \(String(describing: dataSt.stationuuid))")
            }
        }
    }
}

#Preview {
    TestVoteCoreDataView()
}
