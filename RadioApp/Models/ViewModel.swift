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
class ViewModel: ObservableObject {
    private let authService = AuthService.shared
    let network = NetworkService()
    private var amplitudeService = AmplitudeService()
    //
    @Published var isAlert: Bool = false
    
    
    @Published var amplitude: CGFloat = 0.0
    //
    
    @Published var stations = [Station]()
    //    для выбора стартового экрана
    //@Published var selectedView: AnyView = AnyView(ContentView())//AnyView(WelcomeView())
    
    //VolumeView
    //@Published var volume: CGFloat = 0
    //@Published var volume: CGFloat = CGFloat(AVAudioSession.sharedInstance().outputVolume)
    @Published var volume: CGFloat = 0.0
    //PopularView
    @Published var selectedStation = ""
    //VoteView
    @Published var islike: Bool = false
    
    @Published var isPlay: Bool = false
    
    
    // свойства для аутентификации пользователя
    @Published var email = ""
    @Published var password = ""
    @Published var username = "Mark"
    @Published var userProfileImage: UIImage? = nil
    
    
    @Published var showPassword = false
    @Published var isUserRegistered = false
    @Published var showSignInView = false
    
    @Published var testUserEmail = "Franky@gmail.com"
    @Published var testUserPassword = "1212121"
    @Published var testUserUsername = "Frank"
    
    //search
    @Published var searchText: String = ""
    @Published var error: Error?
    
    
    @Published var isActiveDetailView = false
    
    //тест дименого кода
    //@Published var viewModel = ProfileViewModel()

    
    func fetchSearchStations() async throws {
        var fetchSearchStations: [Station]
        fetchSearchStations = try await network.searchByName(searchText: searchText)
        stations = fetchSearchStations
    }
    
    // likes
    var likes = Like(likeSet: Set<String>())
    var player: AVPlayer?
    
    // Audio session object
    let session = AVAudioSession.sharedInstance()
    // Observer
    var progressObserver: NSKeyValueObservation!
    //CoreData
    let container = NSPersistentContainer(name: "LikeStations")
    
    
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
        fetchUser()
        self.volume = CGFloat(session.outputVolume)
        print("init volume value - \(self.volume)")
        setVolme()
        
        getUserInfo()
        
        //инициализация PersistentContainer CoreData
        container.loadPersistentStores{description, error in
            if let error = error {
                print("CoreData failed to load \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    //тестовая функция
    //    func setVolme(){
    //        //        progressObserver = session.observe(\.outputVolume) { [self] (session, value) in
    //        //            DispatchQueue.main.async {
    //        //                self.volume = CGFloat(session.outputVolume)
    //        //            }
    //        //        }
    //        //    }
    
    
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
    
    
    //    func fetchSearchStations() async throws {
    //        var fetchSearchStations: [Station]
    //        fetchSearchStations = try await network.getAllStations()
    //        stations = fetchSearchStations
    //    }
    
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
        
        
        //функция не нужна при отсутствии изменять музыку бегунком
        //        func setVolmePlayer(){
        //            player?.volume = Float(self.volume)
        //            print(player?.volume)
        //        }
        
    }
    
    func playFirstStation() {
        if stations.count > 0 {
            selectedStation = stations[0].stationuuid
            playAudio(url: stations[0].url)
        }
    }
    
    // MARK: - Auth methods
    func getUserInfo() {
        let user = authService.getCurrentUserModel()
        username = user?.userName ?? ""
        userProfileImage = UIImage(named: user?.profileImage ?? Resources.Image.eliseev)
    }
    
    func signIn() async {
        do {
            try await AuthService.shared.signIn(with: email, password: password)
        } catch {
            //self.error = error
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
    
    
    
    
    
    

    
    @Published var currentUser: UserModel?
    //@Published var error: Error?
    
   
    private let notificationService = NotificationsService.shared
    
    // MARK: - Initializer
//    init() {
//
//    }
    
    // MARK: - Methods
    func fetchUser() {
        Task {
             currentUser = authService.getCurrentUserModel()
        }
    }
    
    func getProfileImage(path: String) {
        guard currentUser != nil else { return }
        Task {
          try await authService.getUrlForImage(path: path)
        }
    }
    
    func saveProfileImage(_ image: UIImage) {
        guard let currentUser else { return }
        
        Task {
            let (_, _) = try await authService.saveImage(image: image, userID: currentUser.id) //let (path, name)
        }
    }
    
    func updateUserProfile(_ name: String?, _ email: String?, _ avatar: UIImage?) {
        Task {
            do {
                let photoURL: URL? = nil //var
                
//                if let avatar = avatar {
//                    photoURL = try await authService.uploadAvatar(image: avatar, userId: currentUser?.id ?? "")
//                }
                
                if let email = email {
                    try await authService.updateEmail(email)
                }
                
                try await authService.updateUserProfile(displayName: name, photoURL: photoURL)
                
                await MainActor.run {
                    fetchUser()
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
    
//    func logOut() {
//        do {
//            try authService.signUserOut()
//        } catch {
//            Task {
//                self.error = error
//            }
//        }
//    }
    
    //тест

    
    
    
    
    func clearError() {
        Task {
            self.error = nil
        }
    }
    
//    MARK: - Notifications
   
    func notificationAction() {
        notificationService.sendTestNotification()
    }
}
