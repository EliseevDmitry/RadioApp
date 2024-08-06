//
//  PopularView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 31.07.2024.
//

import SwiftUI

struct UserIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.90768*width, y: 0.58868*height))
        path.addCurve(to: CGPoint(x: 0.90768*width, y: 0.4031*height), control1: CGPoint(x: 0.9846*width, y: 0.54744*height), control2: CGPoint(x: 0.9846*width, y: 0.44434*height))
        path.addLine(to: CGPoint(x: 0.18652*width, y: 0.01648*height))
        path.addCurve(to: CGPoint(x: 0.01345*width, y: 0.10927*height), control1: CGPoint(x: 0.1096*width, y: -0.02476*height), control2: CGPoint(x: 0.01345*width, y: 0.02679*height))
        path.addLine(to: CGPoint(x: 0.01345*width, y: 0.8825*height))
        path.addCurve(to: CGPoint(x: 0.18652*width, y: 0.97529*height), control1: CGPoint(x: 0.01345*width, y: 0.96498*height), control2: CGPoint(x: 0.1096*width, y: 1.01653*height))
        path.addLine(to: CGPoint(x: 0.90768*width, y: 0.58868*height))
        path.closeSubpath()
        return path
    }
}


struct PopularView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var appManager: ViewModel
    let columns = [
        GridItem(.flexible(minimum: 139, maximum: 139)),
        GridItem(.flexible(minimum: 139, maximum: 139))
    ]
    //MARK: - BODY
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Text("Popular")
                        .font(.custom(DS.Fonts.sfRegular, size: 40))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 30)
                Spacer()
                HStack{
                    VolumeView()
                        .frame(width: 33 ,height: 250)
                        .padding(.leading, 15)
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVGrid(columns: columns) {
                            ForEach(appManager.stations, id: \.stationuuid) {item in
                                StationPopularView(selectedStationID: $appManager.selectedStation, station: item)
                                    .environmentObject(appManager)
                                    .frame(width: 139, height: 139)
                            }
                        }
                    }
                    .padding()
                    .overlay {
                        HStack(spacing: 30){
                            BackButtonView()
                            PlayButtonView()
                            ForwardButtonView()
                        }
                        .offset(CGSize(width: 0, height: 260))
                    }
                    Spacer()
                }
                Spacer()
            }
            .background(DS.Colors.darkBlue)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Image(.toolbarplay)
                        .padding(.leading, 10)
                    Text("Hello")
                        .foregroundStyle(.white)
                    Text("Mark")
                        .foregroundStyle(.white)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Image(.eliseev)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                        .mask {
                            UserIcon()
                        }
                }
                
            }
            //.frame(height: 800)
        }
        .ignoresSafeArea()
        
        .task {
            do {
                try await appManager.fetchTopStations()
            } catch let err{
                // handle error
                print(err.localizedDescription)
            }
            appManager.playFirstStation()
        }
        .onAppear{
            appManager.loadLikesData()
            //clear Set Likes
            //            appManager.likes.likeSet.removeAll()
            //            appManager.saveLikesData()
        }
    }
}

//MARK: - PREVIEW
struct PopularView_Previews: PreviewProvider {
    static let previewAppManager = ViewModel()
    static var previews: some View {
        PopularView()
            .environmentObject(previewAppManager)
    }
}




