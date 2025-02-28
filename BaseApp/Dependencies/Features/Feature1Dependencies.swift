import Feature1
import Dependencies

extension Feature1Dependencies: @retroactive DependencyKey {

    public static var liveValue: Self {
        @Dependency(\.coreDependencies.authenticationService) var authenticationService
        return .init(authenticationService: authenticationService)
    }
}
