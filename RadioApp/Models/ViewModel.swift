//
//  ViewModel.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import Foundation
import AVKit
import FirebaseAuth

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

    
    // свойства для аутентификации
    @Published var email = "Franky@gmail.com"
    @Published var password = "1212121"
    @Published var username = "Frank"
    @Published var showPassword = false
    @Published var isUserRegistered = false
    @Published var showSignInView = false
    
    
    let network = NetworkService()
    var likes = Like(likeSet: Set<String>())
    var player: AVPlayer?
    
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
    
    func play(){
        player?.play()
        isPlay = true
    }
    
    func pauseAudioStream(){
            player?.pause()
        isPlay = false
    }
    
    // MARK: - Auth methods
    func signIn() {
        Task {
            try await AuthService.shared.signIn(with: email, password: password)
        }
    }
    
    func registerUser() {
        Task {
            try await AuthService.shared.registerUser(with: email, password: password, username: username)
            isUserRegistered = true
        }
    }
    
    func signOut() {
        Task {
            AuthService.shared.signUserOut()
        }
    }
}
