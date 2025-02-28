import Dependencies
import NetworkProtocols

struct WelcomeClient: Sendable {
    var loginUser: @Sendable (_ email: String, _ password: String) async throws(AuthenticationServiceError) -> Void
    var registerUser: @Sendable (_ email: String, _ password: String, _ phone: String) async throws(AuthenticationServiceError) -> Void
}

extension WelcomeClient: DependencyKey {
    static var liveValue: Self {
        @Dependency(\.dependencies.authenticationService) var authenticationService
        
        return .init(
            loginUser: { email, password throws(AuthenticationServiceError) in
                return try await authenticationService.logInUser(email, password)
            },
            registerUser: { email, password, phone throws(AuthenticationServiceError) in
                return try await authenticationService.registerUser(email, password, phone)
            }
        )
    }
    
    static let previewValue = Self(
        loginUser: { email, password in
            return
        },
        registerUser: { email, password, phone in
            return
        }
    )
}

extension DependencyValues {
    var welcomeClient: WelcomeClient {
        get { self[WelcomeClient.self] }
        set { self[WelcomeClient.self] = newValue }
    }
}
