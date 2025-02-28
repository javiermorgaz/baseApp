import Dependencies
import NetworkProtocols

public struct Feature1Dependencies: Sendable {
    var authenticationService: AuthenticationServiceProtocol

    public init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
}

extension Feature1Dependencies: TestDependencyKey {
    public static var testValue: Self {
        unimplemented("Feature1Dependencies needs to provide its value",
                      placeholder: .testValue)
    }
}

extension DependencyValues {
    public var dependencies: Feature1Dependencies {
        get { self[Feature1Dependencies.self] }
        set { self[Feature1Dependencies.self] = newValue }
    }
}
