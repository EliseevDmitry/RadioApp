//
//  ViewModel.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI
import AVKit
import FirebaseAuth
import CoreData
import AVFoundation
import Combine


@MainActor
final class ViewModel: ObservableObject {
    
    //Авторизация
    private let authService = AuthService.shared
    // свойства для аутентификации пользователя
    @Published var email = "Dr@dr.net"
    @Published var password = "1111111"
    @Published var username = "Mark"
    //фото иконки тулбара
    @Published var userProfileImage: UIImage? = nil
    @Published var error: Error?
    
    
    // MARK: - Auth methods
    //--------Функция дениса по входу в приложение
    func getUserInfo() {
        let user = authService.getCurrentUserModel()
        username = user?.userName ?? ""
        userProfileImage = UIImage(named: user?.profileImage ?? Resources.Image.eliseev)
    }
    
    

    func signIn() async {
            do {
                try await AuthService.shared.signIn(with: email, password: password)
            } catch {
//                self.error = error
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
            try AuthService.shared.signUserOut()
        }
    }
    //--------Функция дениса по входу в приложение
    
    
    
    
    
    
    
    
    
    //Сервис запроса станций
    private let network = NetworkService()
    
    
    //Эквалайзер
    private var amplitudeService = AmplitudeService()
    @Published var amplitude: CGFloat = 0.0
    
    //Массив станций - сердце приложения
    @Published var stations = [Station]()

    //VolumeView
    @Published var volume: CGFloat = 0.0
    
    //PopularView/FavoritesView/AllStationsView
    @Published var selectedStation = ""
    //VoteView
    @Published var islike: Bool = false

    //AVPlayer
    var player: AVPlayer?
    @Published var isPlay: Bool = false
    

    
    //@Published var showPassword = false
    @Published var isUserRegistered = false
    //@Published var showSignInView = false

//    @Published var testUserEmail = "Franky@gmail.com"
//    @Published var testUserPassword = "1212121"
//    @Published var testUserUsername = "Frank"
    
    //search
    @Published var searchText: String = ""
    @Published var isActiveDetailView = false

    
   
    
    
    
    
    
    func fetchSearchStations() async throws {
        var fetchSearchStations: [Station]
        fetchSearchStations = try await network.searchByName(searchText: searchText)
        stations = fetchSearchStations
    }

    
    
    // likes
    var likes = Like(likeSet: Set<String>())
    

    // Audio session object
    let session = AVAudioSession.sharedInstance()
    // Observer
    var progressObserver: NSKeyValueObservation!
    
    
    //---------CoreData--------
    //@Published var container = NSPersistentContainer(name: "LikeStations")
    let container = NSPersistentContainer(name: "LikeStations")
    //---------CoreData--------
    
    
    func setVolme(){
        do {
            try session.setCategory(AVAudioSession.Category.ambient)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch let err {
            print(err.localizedDescription)
        }
        progressObserver = session.observe(\.outputVolume) { [self] (session, value) in
            DispatchQueue.main.async {
                self.volume = CGFloat(session.outputVolume)
                print("current volume value - \(self.volume)")
            }
        }
     
    }

    
    
    //delete Observer
    func unsubscribe() {
        self.progressObserver.invalidate()
    }

    
    
    
    //инициализируем - начальную громкость устройства
    init() {
        self.volume = CGFloat(session.outputVolume)
        print("init volume value - \(self.volume)")
        setVolme()
        
        getUserInfo()
        
        
        //---------CoreData--------
        //инициализация PersistentContainer CoreData
        container.loadPersistentStores{description, error in
            if let error = error {
                print("CoreData failed to load \(error.localizedDescription)")
            }
        }
        //---------CoreData--------
        
    }
    
    




    func fetchTopStations() async throws {
        var fetchedStations: [Station]
        fetchedStations = try await network.getTopStations(numberLimit: 20)
        stations = fetchedStations
    }

    func fetchAllStations() async throws {
        var fetchedAllStations: [Station]
        fetchedAllStations = try await network.getAllStations()
        stations = fetchedAllStations
    }
    
    func voteStationByID(id: String) async throws {
        try await network.voteStationById(id: id)
    }
    
    
    //обновление (votes) текущей станции в случае успешного запроса
    func getOneStationByID(id: String) async throws {
        var fetchedStation: [Station]
        var indexStation: Int?
        fetchedStation = try await network.getStationById(id: id)
        for (index, station) in stations.enumerated() {
            if id == station.stationuuid{
                indexStation = index
            }
        }
        guard let newStation = fetchedStation.first else { return }
        if let id = indexStation {
            print("Изменяем данные (votes) по текущей станции - \(stations[id].votes)")
            stations[id].votes = newStation.votes
            print("Данные (votes) по текущей станции изменены - \(stations[id].votes)")
        }
    }
    
    
    
    //Обновление (votes) аудиостанций не дожидаясь обновления сервера
    func updateVotesWithoutRequest(idStation: String){
        if var updateStation = getStationForID(id:idStation){
            updateStation.votes += 1
            if let id = getIndexStations(idStation: idStation) {
                print("Изменяем данные (votes) по текущей станции - \(stations[id].votes)")
                stations[id].votes = updateStation.votes
                print("Данные (votes) по текущей станции изменены - \(stations[id].votes)")
            }
        }
    }
    
    
    
    //Внутрянняя функция поиска индекса в массиве [Station]()
    func getIndexStations(idStation: String)->Int?{
        for (index, station) in stations.enumerated() {
            if idStation == station.stationuuid{
                return index
            }
        }
        return nil
    }
    
    
    
    
    func setStations(stationData: [StationData]) -> Bool{
        print(stationData)
        stations.removeAll()
        if stationData.count > 0 {
            for station in stationData {
                let likeStation = Station(stationuuid: station.stationuuid ?? "", name: station.name ?? "", url: station.url ?? "", favicon: station.favicon ?? "", tags: station.tags ?? "", countrycode: station.countrycode ?? "", votes: station.votes)
                stations.append(likeStation)
            }
            return true
        } else {
            return false
        }
    }
    
    
    
    func containsElementCoreData(stationData: [StationData], idStation: String) -> Bool{
        for station in stationData {
            if station.stationuuid == idStation {
                return true
            }
        }
        return false
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
            amplitudeService.startUpdatingAmplitude(viewModel: self)

        } catch let err {
            print(err.localizedDescription)
        }
    }

    func playAudioStream(){
        player?.play()
        isPlay = true
        amplitudeService.startUpdatingAmplitude(viewModel: self)
    }

    func pauseAudioStream(){
        player?.pause()
        isPlay = false
        amplitudeService.startUpdatingAmplitude(viewModel: self)
    }
    
    func stopAudioStream() {
            player = nil
            isPlay = false
        selectedStation = ""
    }
    
    
    //запрос данных станции при нажатии на сердечно like
    func getStationForID(id: String) -> Station? {
        var indexStation: Int?
        for (index, station) in stations.enumerated() {
            if selectedStation == station.stationuuid{
                indexStation = index
            }
        }
        if let id = indexStation {
            return stations[id]
        } else {
            return nil
        }
    }

    func nextTrackAudioStream(){
        var indexStation: Int?
        for (index, station) in stations.enumerated() {
            if selectedStation == station.stationuuid{
                indexStation = index
            }
        }
        if indexStation == nil && stations.count > 0{
            selectedStation = stations[0].stationuuid
            playAudio(url: stations[0].url)
            return
        }
        guard var newIndex = indexStation else { return }
        newIndex += 1
        if isPlay && newIndex < stations.count{
            pauseAudioStream()
        }
        if newIndex < stations.count {
            selectedStation = stations[newIndex].stationuuid
            playAudio(url: stations[newIndex].url)
        } else {
            return
        }
    }

    
    
    func backTrackAudioStream() {
        var indexStation: Int?
        for (index, station) in stations.enumerated() {
            if selectedStation == station.stationuuid {
                indexStation = index
            }
        }
        if indexStation == nil && stations.count > 0{
            selectedStation = stations[stations.count-1].stationuuid
            playAudio(url: stations[stations.count-1].url)
            return
        }
        guard var newIndex = indexStation else { return }
        newIndex -= 1
        if isPlay && newIndex >= 0 {
            pauseAudioStream()
        }
        if newIndex >= 0 {
            selectedStation = stations[newIndex].stationuuid
            playAudio(url: stations[newIndex].url)
        } else {
            return
        }
    }

    
    
    func playFirstStation() {
        if stations.count > 0 {
            print(stations.count)
            selectedStation = stations[0].stationuuid
            playAudio(url: stations[0].url)
        }
    }

    //get Tag in String with ","
    func getString(tags: String)->String? {
        let tagsArr = tags.components(separatedBy: ",")
        if tagsArr.count > 0 {
            if tagsArr[0] == "" {
                return nil
            } else {
                return tagsArr[0]
            }
        } else {
            return nil
        }
    }

    
    
    
    
    

}
