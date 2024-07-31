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
        let stations = [StationPopularView(voteCount: .constant(1), isShow: .constant(true), model: model),
                        StationPopularView(voteCount: .constant(2), isShow: .constant(false), model: model),
                        StationPopularView(voteCount: .constant(3), isShow: .constant(false), model: model),
                        StationPopularView(voteCount: .constant(4), isShow: .constant(false), model: model),
                        StationPopularView(voteCount: .constant(5), isShow: .constant(false), model: model),
                        StationPopularView(voteCount: .constant(6), isShow: .constant(false), model: model),
                        StationPopularView(voteCount: .constant(7), isShow: .constant(false), model: model)
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
   
        .background(.green)
    }
        
}

#Preview {
    TestView(model: ViewModel())
}
