import SwiftUI
//import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    static var shared: AppDelegate?
    var deepLink: Deeplink?

    override init() {
        super.init()
        AppDelegate.shared = self
    }
    
    /// This method is called when the app finishes launching.
    ///
    /// - Parameters:
    ///   - application: The application that finished launching.
    ///   - launchOptions: Options for launching the application. This parameter is provided only for compatibility with
    ///     Swift 4.2. In Swift 5.0, this parameter will be removed and `UIApplication.LaunchOptionsKey` will be used instead.
    ///   - return: A boolean value indicating whether the application finished launching successfully.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("📱 The application finished launching")
        UNUserNotificationCenter.current().delegate = self
        //Uncomment the following line to mock a deep link from outside the app
        //deepLink = .feature2
        return true
    }
}

// Handles register of push notifications
extension AppDelegate {
    /// This method is called when the app successfully registers for push notifications.
    ///
    /// - Parameters:
    ///   - application: The application that registered for push notifications.
    ///   - deviceToken: A Data object containing the device token.
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("📜 Registered for push notifications with device token: \(token)")
    }
    
    /// This method is called when the app fails to register for push notifications.
    ///
    /// - Parameters:
    ///   - application: The application that failed to register for push notifications.
    ///   - error: An error describing the reason for the failure.
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("📜 Failed to register for push notifications: \(error)")
    }

    /// This method is called when the app receives a remote notification, and is used to handle silent notifications,
    /// which are notifications that don't display an alert or play a sound, but are used to trigger background processing.
    ///
    /// - Parameters:
    ///   - application: The application that received the notification.
    ///   - userInfo: A dictionary with information about the notification.
    ///   - completionHandler: A closure that the delegate should call with one of the following results:
    ///     - `UIBackgroundFetchResult.newData`: The app successfully processed the notification and fetched new data.
    ///     - `UIBackgroundFetchResult.noData`: The app successfully processed the notification but did not fetch new data.
    ///     - `UIBackgroundFetchResult.failed`: The app failed to process the notification.
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("📬 Push silent notification received: \(userInfo)")
        completionHandler(.newData)
    }
}

// Handles received push notifications
extension AppDelegate: UNUserNotificationCenterDelegate {
    /// This method is called when a user taps a notification, and is used to handle the user's action.
    ///
    /// - Parameters:
    ///   - center: The notification center that sent the notification.
    ///   - response: The user's response to the notification.
    ///   - completionHandler: A closure that the delegate should call with the result of the user's action.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("📬 Push notification tapped: \(response)")
        completionHandler()
    }
    
    /// Triggered when a notification is received in foreground.
    ///
    /// - Parameters:
    ///   - center: The notification center that sent the notification.
    ///   - notification: The notification received.
    ///   - completionHandler: A closure that the delegate should call with a set of
    ///     `UNNotificationPresentationOptions` that specify how to handle the notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("📬 Push notification received in foreground: \(notification)")
        completionHandler([.sound])
    }
}
