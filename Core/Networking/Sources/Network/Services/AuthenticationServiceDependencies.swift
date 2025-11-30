import Dependencies
import NetworkingProtocols
import SessionProtocols

public struct AuthenticationServiceDependencies: Sendable {
    public var apiClient: APIClientProtocol
    public var sessionManager: SessionManagerProtocol
    
    public init(apiClient: APIClientProtocol,
                sessionManager: SessionManagerProtocol) {
        self.apiClient = apiClient
        self.sessionManager = sessionManager
    }
}

extension AuthenticationServiceDependencies: TestDependencyKey {
    public static var testValue: Self {
        unimplemented("AuthenticationServiceDependencies needs to provide its value",
                      placeholder: .testValue)
    }
}

extension DependencyValues {
    public var dependencies: AuthenticationServiceDependencies {
        get { self[AuthenticationServiceDependencies.self] }
        set { self[AuthenticationServiceDependencies.self] = newValue }
    }
}
