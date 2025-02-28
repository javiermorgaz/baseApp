import Dependencies
import NetworkProtocols

public struct Feature2Dependencies: Sendable {
    var authenticationService: AuthenticationServiceProtocol

    public init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
}

extension Feature2Dependencies: TestDependencyKey {
    public static var testValue: Self {
        unimplemented("Feature2Dependencies needs to provide its value",
                      placeholder: .testValue)
    }
}

extension DependencyValues {
    public var dependencies: Feature2Dependencies {
        get { self[Feature2Dependencies.self] }
        set { self[Feature2Dependencies.self] = newValue }
    }
}
