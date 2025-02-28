import Dependencies
import Foundation
import Network
import NetworkProtocols
import Session
import SessionProtocols

struct CoreDependencies {
    var apiClient: APIClientProtocol
    var sessionManager: SessionManagerProtocol
    var authenticationService: AuthenticationServiceProtocol
}

extension CoreDependencies: DependencyKey {
    static let liveValue: CoreDependencies = {
        let sessionManager = SessionManager()
        let apiClient = DefaultAPIClient(baseURL: URL(string: "ADD BACKEND URL")!,
                                         sessionManager: sessionManager)
        let authenticationService = AuthenticationService.liveValue
        return Self(
            apiClient: apiClient,
            sessionManager: sessionManager,
            authenticationService: authenticationService
        )
    }()
}

extension DependencyValues {
    var coreDependencies: CoreDependencies {
        get { self[CoreDependencies.self] }
        set { self[CoreDependencies.self] = newValue }
    }
}
