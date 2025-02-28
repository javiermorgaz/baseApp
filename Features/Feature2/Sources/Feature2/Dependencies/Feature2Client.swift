import Dependencies

struct Feature2Client: Sendable {
    var logOutUser: @Sendable () async throws -> Void
}

extension Feature2Client: DependencyKey {
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
    var feature2Client: Feature2Client {
        get { self[Feature2Client.self] }
        set { self[Feature2Client.self] = newValue }
    }
}
