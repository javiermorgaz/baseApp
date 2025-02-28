import ComposableArchitecture
import SwiftUI
import Welcome
import Feature2
import Register

@Reducer
struct AppFeature {
    @Dependency(\.coreDependencies.authenticationService) var authenticationService

    @Reducer(state: .equatable)
    enum Path {
        case tabs(TabsFeature)
    }

    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        var welcome = WelcomeFeature.State()
        var isLoggedIn: Bool?
        var deepLink: Deeplink? = nil
        @Presents var register: RegisterFeature.State?
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case welcome(WelcomeFeature.Action)
        case register(PresentationAction<RegisterFeature.Action>)
        case checkAuthentication
        case isAuthenticated(Bool)
        case navigate
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.welcome, action: \.welcome) {
            WelcomeFeature()
        }

        Reduce { state, action in
            switch action {
            case .checkAuthentication:
                return .run { send in
                    do {
                        try await authenticationService.isAuthenticated()
                        await send(.isAuthenticated(true))
                    } catch {
                        await send(.isAuthenticated(false))
                    }
                }
                
            case .isAuthenticated(let logged):
                state.isLoggedIn = logged
                return .none
            case .navigate:
                if let isLoggedIn = state.isLoggedIn,
                   isLoggedIn {
                    let deepLink = state.deepLink?.getPath()
                    state.path.append(deepLink ?? .tabs(TabsFeature.State()))
                }
                return .none
            case .path(.element(let id, .tabs(.feature1(.logOutSuccess)))):
                state.path.pop(from: id)
                state.isLoggedIn = false
                return .none
            case .welcome(.signUpTapped):
                state.register = RegisterFeature.State()
                return .none
            case .welcome(.signInSuccess):
                state.isLoggedIn = true
                return .run { send in
                    await send(.navigate)
                }
            case .register(.presented(.signInTapped)):
                state.register = nil
                return .none
            case .register(.presented(.path(.element(_, .confirmation(.confirmationTapped))))):
                state.register = nil
                return .none
            case .path:
                return .none
            case .welcome:
                return .none
            case .register:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$register, action: \.register) {
            RegisterFeature()
        }
    }
}
