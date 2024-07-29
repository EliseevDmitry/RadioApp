//
//  TestView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct TestView: View {
    var stations = [StationPopularView(voteCount: .constant(1)), 
                    StationPopularView(voteCount: .constant(2)),
                    StationPopularView(voteCount: .constant(3)),
                    StationPopularView(voteCount: .constant(4)),
                    StationPopularView(voteCount: .constant(5)),
                    StationPopularView(voteCount: .constant(6)),
                    StationPopularView(voteCount: .constant(7)),
                    StationPopularView(voteCount: .constant(8))
    ]
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columns) {
                ForEach(stations, id: \.voteCount) {item in
                    item
                }
            }
        }
        .padding()
   
        
    }
}

#Preview {
    TestView()
}
