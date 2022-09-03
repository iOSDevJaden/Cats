//
//  NotificationManager.swift
//  Cats
//
//  Created by 김태호 on 2022/09/03.
//

import Foundation
import NotificationCenter

class NotificationManager {
    
    static let instance = NotificationManager()
    
    private lazy var notificationContent: UNMutableNotificationContent = {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = Const.notificationContentTitle
        return notificationContent
    }()
    
    private init() { }
    
    private let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
    
    weak var notificationDelegate: UNUserNotificationCenterDelegate?
    
    private var notificationCenter: UNUserNotificationCenter {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = notificationDelegate
        return notificationCenter
    }
    
    func requestNotificationCenterPermissions() {
        notificationCenter.requestAuthorization(
            options:[.badge, .sound, .alert],
            completionHandler: handleNotificationPermissions(granted:error:))
    }
    
    func getNotificationContent() -> UNMutableNotificationContent {
        self.notificationContent
    }
    
    func setNotificationContent(_ notificationContent: String) -> Self {
        self.notificationContent.body = notificationContent
        return self
    }
    
    func getNotificationRequest() -> UNNotificationRequest {
        UNNotificationRequest(identifier: UUID().uuidString,
                              content: getNotificationContent(),
                              trigger: trigger)
    }
    
    func addNotificationPush() {
        notificationCenter.add(getNotificationRequest())
    }
    
    private func handleNotificationPermissions(
        granted: Bool,
        error: Error?
    ) {
        print("Granted \(granted)")
    }
    
    enum Const {
        static let notificationContentTitle = "Cats"
    }
}
