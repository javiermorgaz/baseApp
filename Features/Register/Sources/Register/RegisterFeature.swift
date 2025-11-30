import ComposableArchitecture
import Dependencies
import Extensions
import NetworkingProtocols
import Strings

@Reducer
public struct RegisterFeature: Sendable {
        
    @Dependency(\.registerClient) var registerClient

    private enum DebounceActionId {
        case signUpTapped
    }
    
    public init() {}
    
    
    @Reducer(state: .equatable)
    public enum Path {
        case confirmation(ConfirmationFeature)
    }
    
    @ObservableState
    public struct State: Equatable {
        var path = StackState<Path.State>()
        var email = ""
        var password = ""
        var emailError = ""
        var passwordError = ""
        public init() {}
    }
    
    public enum Action {
        case path(StackActionOf<Path>)
        case signInTapped
        case signUpTapped
        case singUpSuccess
        case singUpError(AuthenticationServiceError)
        case emailUpdated(String)
        case passWordUpdated(String)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signInTapped:
                return .none
            case .signUpTapped:
                state.emailError = ""
                state.passwordError = ""
                
                checkFormError(&state)

                if state.emailError.isEmpty && state.passwordError.isEmpty {
                    return .run { [email = state.email,
                                   password = state.password] send in
                        do {
                            try await registerClient.createUser(email, password, "")
                            await send(.singUpSuccess)
                        } catch let error as AuthenticationServiceError {
                            await send(.singUpError(error))
                        }
                    }.debounce(id: DebounceActionId.signUpTapped)
                }
                return .none
            case .singUpSuccess:
                state.path.append(.confirmation(ConfirmationFeature.State()))
                return .none
            case .singUpError(let error):
                switch error {
                case .weakPassword:
                    state.passwordError = String(localeCatalogKey: "Feature.Register.Password.Format")
                default:
                    break
                }
                return .none
            case .emailUpdated(let email):
                state.email = email
                return .none
            case .passWordUpdated(let password):
                state.password = password
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    
    private func checkFormError(_ state: inout RegisterFeature.State) {
        if state.email.isEmpty {
            state.emailError = String(localeCatalogKey: "Feature.Register.Email.Empty")
        } else if !registerClient.validateEmail(state.email) {
            state.emailError = String(localeCatalogKey: "Feature.Register.Email.Format")
        }
        
        if state.password.isEmpty {
            state.passwordError = String(localeCatalogKey: "Feature.Register.Password.Empty")
        } else if !registerClient.validatePassword(state.password) {
            state.passwordError = String(localeCatalogKey: "Feature.Register.Password.Format")
        }
    }
}
