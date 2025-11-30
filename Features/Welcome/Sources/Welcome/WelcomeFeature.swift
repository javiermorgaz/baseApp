import ComposableArchitecture
import NetworkingProtocols
import Extensions
import Error
import Strings

@Reducer
public struct WelcomeFeature: Sendable {
    
    @Dependency(\.welcomeClient) var welcomeClient
    
    private enum DebounceActionId {
        case signInSuccess
    }
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var email = ""
        var password = ""
        var emailError = ""
        var passwordError = ""
        var isLoading = false
        @Presents var errorAlertSignIn: ErrorFeature.State?

        public init() {}
    }
    
    public enum Action {
        case signInTapped
        case signInSuccess
        case signInFailed(AuthenticationServiceError)
        case signUpTapped
        case emailUpdated(String)
        case passWordUpdated(String)
        case errorAlertSignIn(PresentationAction<ErrorFeature.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signInTapped:
                state.emailError = ""
                state.passwordError = ""
                
                checkFormError(&state)
                
                if state.emailError.isEmpty && state.passwordError.isEmpty {
                    state.isLoading = true
                    return .run { [email = state.email,
                                   password = state.password] send in
                        do {
                            try await welcomeClient.loginUser(email, password)
                            await send(.signInSuccess)
                        } catch let error as AuthenticationServiceError {
                            await send(.signInFailed(error))
                        }
                    }.debounce(id: DebounceActionId.signInSuccess)
                }
                return .none
            case .signUpTapped:
                return .none
            case .signInSuccess:
                state.email = ""
                state.password = ""
                state.isLoading = false
                return .none
            case .signInFailed(let error):
                state.isLoading = false
                handleSignIn(error, in: &state)
                return .none
            case .errorAlertSignIn(.presented(.closeTapped)):
                state.errorAlertSignIn = nil
                return .none
            case .errorAlertSignIn(.dismiss):
                state.errorAlertSignIn = nil
                return .none
            case .emailUpdated(let email):
                state.email = email
                return .none
            case .passWordUpdated(let password):
                state.password = password
                return .none
            }
        }
        .ifLet(\.$errorAlertSignIn, action: \.errorAlertSignIn) {
            ErrorFeature()
        }
    }
    
    private func checkFormError(_ state: inout WelcomeFeature.State) {
        if state.email.isEmpty {
            state.emailError = String(localeCatalogKey: "Feature.Register.Email.Empty")
        }
        
        if state.password.isEmpty {
            state.passwordError = String(localeCatalogKey: "Feature.Register.Password.Empty")
        }
    }
    
    private func handleSignIn(_ error: AuthenticationServiceError,
                              in state: inout WelcomeFeature.State) {
        switch error {
        case .emailNotConfirmed:
            state.errorAlertSignIn = ErrorFeature.State(
                title: "Feature.Welcome.Login.Error.Title",
                body: "Feature.Welcome.Login.Error.Body.EmailNotConfirmed",
                buttonTitle: "Feature.Welcome.Login.Error.Button.Accept")
        case .invalidCredentials:
            state.errorAlertSignIn = ErrorFeature.State(
                title: "Feature.Welcome.Login.Error.Title",
                body: "Feature.Welcome.Login.Error.Body.EmailNotConfirmed",
                buttonTitle: "Feature.Welcome.Login.Error.Button.Accept")
        default:
            state.errorAlertSignIn = ErrorFeature.State(
                title: "Feature.Welcome.Login.Error.Title",
                body: "Feature.Welcome.Login.Error.Body.Unknown",
                buttonTitle: "Feature.Welcome.Login.Error.Button.Accept")
        }
    }
}
