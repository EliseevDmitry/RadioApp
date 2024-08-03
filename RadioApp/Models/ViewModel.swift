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
    //@Published var volume: CGFloat = 0
@Published var volume: CGFloat = CGFloat(AVAudioSession.sharedInstance().outputVolume)
    @Published var geometryVolume: CGFloat = 0.0
//    @Published var volume: CGFloat = 0.5
    //PopularView
    @Published var selectedStation = ""
    //VoteView
    @Published var islike: Bool = false
    
    @Published var isPlay: Bool = false
    
    
    let network = NetworkService()
    var likes = Like(likeSet: Set<String>())
    var player: AVPlayer?

    
    // Audio session object
    private let session = AVAudioSession.sharedInstance()
    
    // Observer
    private var progressObserver: NSKeyValueObservation!
    
    func subscribe() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("cannot activate session")
        }
        
        progressObserver = session.observe(\.outputVolume) { [self] (session, value) in
            DispatchQueue.main.async {
                self.volume = CGFloat(session.outputVolume)
                self.geometryVolume = self.volume
            }
        }
    }
    
    func unsubscribe() {
        self.progressObserver.invalidate()
    }
    
    init() {
        subscribe()
    }
    
    
    
    
    
//     init() {
//            do {
//                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
//                try session.setActive(true, options: .notifyOthersOnDeactivation)
//                self.volume = 0.5
//            } catch {
//                print("cannot activate session")
//            }
//    
//            
//         
//        }
//    
//    func setValueVolume() async throws {
//        progressObserver = session.observe(\.outputVolume) { [self] (session, value) in
//                print(session.outputVolume)
//                
//                volume = CGFloat(session.outputVolume)
//            }
//        }
//    }

    
//    
//    //audio
//    
//    // Audio session object
//    let session = AVAudioSession.sharedInstance()
//       // Observer
//    @Published var progressObserver: NSKeyValueObservation!
//    
//    
    
    
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
    
    func setVolme(){
        player?.volume = Float(geometryVolume)

    }
    
    
    
}



