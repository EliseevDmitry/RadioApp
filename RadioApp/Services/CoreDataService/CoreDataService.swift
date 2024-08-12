//
//  CoreDataService.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 11.08.2024.
//

import Foundation
import CoreData

final class CoreDataService {
    
    let container: NSPersistentContainer
    private let containerName: String = "LikeStations"
    private let entityName: String = "StationData"
    
    @Published var savedEntities: [StationData] = []
    
    public static let shared = CoreDataService()
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error.localizedDescription)")
            }
//            self.getLikeStation()
        }
    }
    
//    // MARK: PUBLIC
//    func updateLike(station: Station) {
//        // check if coin is already in portfolio
//        if let entity = savedEntities.first(where: { $0.stationuuid == station.stationuuid }) {
//            if station.id {
//                update(entity: entity)
//            } else {
//                delete(entity: entity)
//            }
//        } else {
//            add(coin: coin, amount: amount)
//        }
//    }
//    
//    
//    private func getLikeStation() {
//        let request = NSFetchRequest<StationData>(entityName: entityName)
//        do {
//            savedEntities = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching Portfolio Entities. \(error.localizedDescription)")
//        }
//    }
//    
//    private func add(station: Station) {
//        let entity = StationData(context: container.viewContext)
//        entity.stationuuid = station.stationuuid
//        entity.name = station.name
//        applyChanges()
//    }
//    
//    
//    private func update(entity: StationData) {
//        entity.id
//        applyChanges()
//    }
//    
//    private func delete(entity: StationData) {
//        container.viewContext.delete(entity)
//        applyChanges()
//    }
//    
//    private func save() {
//        do {
//            try container.viewContext.save()
//        } catch let error {
//            print("Error saving to Core Data. \(error)")
//        }
//    }
//    
//    private func applyChanges() {
//        save()
//        getLikeStation()
//    }
//    
//    
//    
//    func containsElementCoreData(stationData: [StationData], idStation: String) -> Bool{
//        for station in stationData {
//            if station.stationuuid == idStation {
//                return true
//            }
//        }
//        return false
//    }
}
    

