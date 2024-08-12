//
//  NotificationsService.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 08.08.2024.
//


import Foundation
import UserNotifications

final class NotificationsService {
    // MARK: - Properties
    public static let shared = NotificationsService()
    var hasRequestedNotifications: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "hasRequestedNotifications")
        }
        set {
            if newValue != hasRequestedNotifications {
                saveNotificationPreference(newValue)
                if newValue {
                    requestNotificationAuthorization()
                }
            }
        }
    }
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods
    private func saveNotificationPreference(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: "hasRequestedNotifications")
    }
    
    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications authorized")
            } else if let error = error {
                print("Authorization failed: \(error.localizedDescription)")
            }
        }
    }
    
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Уведомления включены"
        content.body = "Вы успешно включили уведомления в приложении."
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
