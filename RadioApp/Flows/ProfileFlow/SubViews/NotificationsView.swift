//
//  NotificationView.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 07.08.2024.
//

import SwiftUI
import UserNotifications

struct NotificationsView: View {
    // MARK: - Properties
    @AppStorage("selectedLanguage") private var language = LocalizationService.shared.language
    @AppStorage("hasRequestedNotifications") private var isToggleOn: Bool = NotificationsService.shared.hasRequestedNotifications
    var notificationAction: () -> Void
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let iconSize: CGFloat = 40
        static let iconPadding: CGFloat = 10
        static let textSize: CGFloat = 14
        static let buttonPadding: CGFloat = 10
        static let strokeWidth: CGFloat = 0.8
        static let cornerRadius: CGFloat = 10
        static let strokeOpacity: CGFloat = 0.3
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 24
        static let dividerOpacity: CGFloat = 0.2
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            backgroundColor
            content
        }
        .navigationTitle(Resources.Text.notification.localized(language))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackBarButton()
            }
        }
    }
    
    // MARK: - Private Views
    private var backgroundColor: some View {
        DS.Colors.darkBlue
            .ignoresSafeArea()
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            header
            notificationToggle
            timeAndDaysPicker
        }
        .overlay(
            RoundedRectangle(cornerRadius: Drawing.cornerRadius)
                .stroke(Color.gray, lineWidth: Drawing.strokeWidth)
                .opacity(Drawing.strokeOpacity)
        )
        .padding(.horizontal, Drawing.horizontalPadding)
    }
    
    private var header: some View {
        HStack {
            Text(Resources.Text.messagesNotifications.localized(language))
                .font(Font.custom(.sfMedium, size: Drawing.textSize))
                .foregroundColor(.white)
                .padding(.leading, Drawing.horizontalPadding)
                .padding(.top, Drawing.verticalPadding)
            Spacer()
        }
    }
    
    private var notificationToggle: some View {
        HStack {
            Text(Resources.Text.showNotifications.localized(language))
                .font(Font.custom(.sfMedium, size: Drawing.textSize))
                .foregroundColor(.white)
            Toggle(isOn: $isToggleOn) {
                Text("")
            }
            .onChange(of: isToggleOn) { newValue in
                handleNotificationToggleChange(newValue)
            }
            .toggleStyle(SwitchToggleStyle(tint: DS.Colors.blueNeon))
        }
        .padding(.horizontal, Drawing.horizontalPadding)
        .padding(.vertical, Drawing.iconPadding)
    }
    
    private var timeAndDaysPicker: some View {
        VStack {
            Divider()
                .background(Color.gray)
                .padding(.horizontal, Drawing.horizontalPadding)
                .opacity(Drawing.dividerOpacity)
            
            HStack {
                Text(Resources.Text.selectTimeAndDays.localized(language))
                    .font(Font.custom(.sfMedium, size: Drawing.textSize))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal, Drawing.horizontalPadding)
            .padding(.top, Drawing.iconPadding)
            
            TimeAndDaysPicker()
                .padding(.horizontal, Drawing.horizontalPadding)
                .padding(.bottom, Drawing.verticalPadding)
        }
    }
    
    // MARK: - Private Methods
    private func handleNotificationToggleChange(_ isOn: Bool) {
        if isOn {
            NotificationsService.shared.sendTestNotification()
        }
        notificationAction()
    }
}

//MARK: - PREVIEW
#Preview {
    NotificationsView(notificationAction: {
        print("Notification toggle changed")
    })
}
