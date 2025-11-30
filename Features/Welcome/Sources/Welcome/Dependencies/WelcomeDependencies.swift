import Dependencies
import SessionProtocols
import NetworkingProtocols

public struct WelcomeDependencies: Sendable {
    var authenticationService: AuthenticationServiceProtocol

    public init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
}

extension WelcomeDependencies: TestDependencyKey {
    public static var testValue: Self {
        unimplemented("WelcomeDependencies needs to provide its value",
                      placeholder: .testValue)
    }
}

extension DependencyValues {
    public var dependencies: WelcomeDependencies {
        get { self[WelcomeDependencies.self] }
        set { self[WelcomeDependencies.self] = newValue }
    }
}
