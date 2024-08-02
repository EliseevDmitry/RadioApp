//
//  ViewModel.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import Foundation
import AVKit


@MainActor
final class ViewModel: ObservableObject {
    
    // добавляем сюда другие @Published свойства
    @Published var stations = [Station]()
    //VolumeView
    @Published var volume: CGFloat = 0.5
    //PopularView
    @Published var selectedStation = ""
    //VoteView
    @Published var islike: Bool = false
    
    @Published var isPlay: Bool = false

    
    let network = NetworkService()
    var likes = Like(likeSet: Set<String>())
    var player: AVPlayer?
    var session = AVAudioSession.sharedInstance()
    
    func fetchTopStations() async throws {
        var fetchedStations: [Station]
        fetchedStations = try await network.getTopStations(numberLimit: 15)
        stations = fetchedStations
    }
    
    //save likes
    func saveLikesData(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(likes) {
            UserDefaults.standard.set(data, forKey: "likes")
        }
    }
    
    //load likes
    func loadLikesData(){
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "likes") else { return }
        guard let loadData = try? decoder.decode(Like.self, from: data) else {return}
        likes.likeSet = loadData.likeSet
    }
    
    //проверка на наличие уже оставленного отзыва
    //возвращает false при уже оставленном like
    func saveIDLikes(id: String) -> Bool {
        defer {
            saveLikesData()
        }
        if !likes.likeSet.contains(id) {
            print("ID будет добавлен - \(id)")
            likes.likeSet.insert(id)
            print(likes.likeSet)
            return true
        }
        print("Такой ID уже существует!")
        return false
    }
    
    func playAudio(url: String){
        guard let url = URL.init(string: url) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: url)
            player?.play()
            isPlay = true
        } catch {
            //
        }
    }
    
    func playAudioStream(){
        player?.play()
        isPlay = true
    }
    
    func pauseAudioStream(){
            player?.pause()
        isPlay = false
    }
    
    func nextTrackAudioStream(){
        var indexStation: Int?
        for (index, station) in stations.enumerated() {
            if selectedStation == station.changeuuid{
                indexStation = index
            }
        }
        if indexStation == nil && stations.count > 0{
            selectedStation = stations[0].changeuuid
            playAudio(url: stations[0].url)
            return
        }
        guard var newIndex = indexStation else { return }
        newIndex += 1
        if isPlay && newIndex < stations.count{
            pauseAudioStream()
        }
        if newIndex < stations.count {
            selectedStation = stations[newIndex].changeuuid
            playAudio(url: stations[newIndex].url)
        } else {
            return
        }
    }
    
    func backTrackAudioStream(){
        var indexStation: Int?
        for (index, station) in stations.enumerated() {
            if selectedStation == station.changeuuid{
                indexStation = index
            }
        }
        if indexStation == nil && stations.count > 0{
            selectedStation = stations[stations.count-1].changeuuid
            playAudio(url: stations[stations.count-1].url)
            return
        }
        guard var newIndex = indexStation else { return }
        newIndex -= 1
        if isPlay && newIndex >= 0{
            pauseAudioStream()
        }
        if newIndex >= 0 {
            selectedStation = stations[newIndex].changeuuid
            playAudio(url: stations[newIndex].url)
        } else {
            return
        }
    }
    
    func playFirstStation(){
        if stations.count > 0{
            selectedStation = stations[0].changeuuid
            playAudio(url: stations[0].url)
        }
    }
    
//    func setVolme(){
//        do {
//            try session.setActive(true)
//            session.publisher(for: \.outputVolume){value in
//                
//            }
//        } catch {
//            
//        }
//    }
    

    
}


