import Dependencies
import NetworkProtocols

public struct RegisterDependencies: Sendable {
    var authenticationService: AuthenticationServiceProtocol

    public init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
}

extension RegisterDependencies: TestDependencyKey {
    public static var testValue: Self {
        unimplemented("RegisterDependencies needs to provide its value",
                      placeholder: .testValue)
    }
}

extension DependencyValues {
    public var dependencies: RegisterDependencies {
        get { self[RegisterDependencies.self] }
        set { self[RegisterDependencies.self] = newValue }
    }
}
