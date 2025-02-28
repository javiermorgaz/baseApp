import SwiftUI
import ComposableArchitecture

@main
struct BaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    @MainActor
    static let store = Store(initialState:
                                AppFeature.State(deepLink: AppDelegate.shared?.deepLink)
    ) {
        AppFeature()._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            if TestContext.current == nil {
                AppView(store: Self.store)
                    .onAppear {
                        print("📱 The app view appear")
                    }
                    .onChange(of: scenePhase, initial: false) { oldPhase, newPhase  in
                        switch newPhase {
                        case .active:
                            print("📱 The app is in the foreground and active")
                        case .inactive:
                            print("📱 The app is in the foreground and inactive")
                        case .background:
                            print("📱 The app is in the background")
                        @unknown default:
                            print("📱 The app is in a unknown state")
                        }
                    }
            }
        }
    }
}

enum Deeplink {
    case feature1
    case feature2
    
    func getPath() -> AppFeature.Path.State {
        switch self {
        case .feature1:
            return .tabs(TabsFeature.State(selectedTab: .feature1))
        case .feature2:
            return .tabs(TabsFeature.State(selectedTab: .feature2))
        }
    }
}

