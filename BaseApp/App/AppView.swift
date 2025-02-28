import SwiftUI
import ComposableArchitecture
import Welcome
import Feature1
import DesignSystem
import Register

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        if store.isLoggedIn == nil {
            FullScreenLoader(type: .opaque)
                .onAppear {
                    store.send(.checkAuthentication)
                }
                .onDisappear() {
                    store.send(.navigate)
                }
        } else {
            NavigationStack(path: $store.scope(state: \.path,
                                               action: \.path)
            ) {
                WelcomeScreen(store: store.scope(state: \.welcome,
                                                 action: \.welcome))
            } destination: { store in
                switch store.case {
                case let .tabs(store):
                    TabsView(store: store)
                }
            }
            .sheet(
                item: $store.scope(state: \.register, action: \.register)
            ) { store in
                RegisterScreen(store: store)
            }
        }
    }
}

#Preview ("Getting Session") {
    AppView(store: Store(initialState: AppFeature.State(isLoggedIn: nil)) {
        AppFeature()
    })
}

#Preview ("Session not authenticated") {
    AppView(store: Store(initialState: AppFeature.State( isLoggedIn: false)) {
        AppFeature()
    })
}
