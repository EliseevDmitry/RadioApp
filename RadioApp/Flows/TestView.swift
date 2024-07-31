//
//  TestView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 29.07.2024.
//

import SwiftUI

struct TestView: View {
    var model: ViewModel

    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        let stations = [StationPopularView(voteCount: .constant(1), model: model),
                        StationPopularView(voteCount: .constant(2), model: model),
                        StationPopularView(voteCount: .constant(3), model: model),
                        StationPopularView(voteCount: .constant(4), model: model),
                        StationPopularView(voteCount: .constant(5), model: model),
                        StationPopularView(voteCount: .constant(6), model: model),
                        StationPopularView(voteCount: .constant(7), model: model)
        ]
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columns) {
                ForEach(stations, id: \.voteCount) {item in
                    item
                        //.padding(4)
                      
                }
            }
        }
        .padding()
   
        
    }
}

#Preview {
    TestView(model: ViewModel())
}
