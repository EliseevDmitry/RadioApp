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
            path.move(to: CGPoint(x: 0.76179*width, y: 0.66313*height))
            path.addCurve(to: CGPoint(x: 0.76179*width, y: 0.33786*height), control1: CGPoint(x: 0.93222*width, y: 0.58821*height), control2: CGPoint(x: 0.93222*width, y: 0.41278*height))
            path.addLine(to: CGPoint(x: 0.52988*width, y: 0.23593*height))
            path.addCurve(to: CGPoint(x: 0.116*width, y: 0.39854*height), control1: CGPoint(x: 0.34951*width, y: 0.15658*height), control2: CGPoint(x: 0.116*width, y: 0.24833*height))
            path.addLine(to: CGPoint(x: 0.116*width, y: 0.60245*height))
            path.addCurve(to: CGPoint(x: 0.52988*width, y: 0.76506*height), control1: CGPoint(x: 0.116*width, y: 0.75266*height), control2: CGPoint(x: 0.34951*width, y: 0.84441*height))
            path.addLine(to: CGPoint(x: 0.76179*width, y: 0.66313*height))
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
                HStack{
                    VolumeView()
                        .frame(width: 33 ,height: 250)
                        .padding(.leading, 15)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        HStack {
                            Text("Popular")
                                .font(.custom(DS.Fonts.sfRegular, size: 35))
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 10)
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
            
            //NavigationToolBar
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Image(.toolbarplay)
                        .padding(.leading, 10)
                    Text("Hello")
                        .foregroundStyle(.white)
                        .font(.custom(DS.Fonts.sfMedium, size: 30))
                    //@Published var username = "Mark" - наблюдаемое свойство имени
                    Text("\(appManager.username)")
                        .foregroundStyle(DS.Colors.pinkNeon)
                        .font(.custom(DS.Fonts.sfMedium, size: 30))
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    /*
                    Button{
                        ProfileView()
                    } label: {
                        //изображение пользователя
                        Image(.eliseevd)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 70)
                            .mask {
                                UserIcon()
                                    .frame(width: 60, height: 70)
                            }
                    }
                    .padding(.trailing, 10)
                    
                    */
                    /*
                    NavigationLink(
                        destination: ProfileView()
                            .environmentObject(appManager)
                            .navigationBarBackButtonHidden()
                    ) {
                        //изображение пользователя
                        Image(.eliseevd)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 70)
                            .mask {
                                UserIcon()
                                    .frame(width: 60, height: 70)
                            }
                    }
                    .padding(.trailing, 10)
                    */
                    
                    /*
                     NavigationLink(
                         destination: SignUpView()
                             .environmentObject(appManager)
                             .navigationBarBackButtonHidden()
                     ) {
                         Text(Resources.Text.orSignUp)
                             .foregroundStyle(.white)
                         /*
                         CustomButton(
                             action: {},
                             title: Resources.Text.getStarted,
                             buttonType: .onboarding)
                         */
                     }
                    */
                }
            }
            
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




