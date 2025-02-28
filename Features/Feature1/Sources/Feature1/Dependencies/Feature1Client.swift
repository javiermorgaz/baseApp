import Dependencies

struct Feature1Client: Sendable {
    var logOutUser: @Sendable () async throws -> Void
}

extension Feature1Client: DependencyKey {
    static var liveValue: Self {
        @Dependency(\.dependencies.authenticationService) var authenticationService
        return .init(logOutUser: {
            return try await authenticationService.logOutUser()
        })
    }
    
    static let previewValue = Self(
        logOutUser: { return }
    )
}

extension DependencyValues {
    var feature1Client: Feature1Client {
        get { self[Feature1Client.self] }
        set { self[Feature1Client.self] = newValue }
    }
}
