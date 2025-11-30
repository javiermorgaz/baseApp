import Dependencies
import Networking
import NetworkingProtocols
import Session
import SessionProtocols

struct ServiceDependencies {
    var authenticationServiceDependencies: AuthenticationServiceDependencies
}

extension ServiceDependencies: DependencyKey {
    static var liveValue: ServiceDependencies {
        @Dependency(\.coreDependencies.apiClient) var apiClient
        @Dependency(\.coreDependencies.sessionManager) var sessionManager
        
        return Self(
            authenticationServiceDependencies: AuthenticationServiceDependencies(apiClient: apiClient,
                                                                                 sessionManager: sessionManager)
        )
    }
}

extension DependencyValues {
    var serviceDependencies: ServiceDependencies {
        get { self[ServiceDependencies.self] }
        set { self[ServiceDependencies.self] = newValue }
    }
}

extension AuthenticationServiceDependencies: @retroactive DependencyKey  {
    public static var liveValue: AuthenticationServiceDependencies {
        ServiceDependencies.liveValue.authenticationServiceDependencies
    }
}
