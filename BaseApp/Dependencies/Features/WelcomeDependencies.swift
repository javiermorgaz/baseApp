import Welcome
import Dependencies

extension WelcomeDependencies: @retroactive DependencyKey  {
    
    public static var liveValue: Self {
        @Dependency(\.coreDependencies.authenticationService) var authenticationService
        return .init(authenticationService: authenticationService)
    }
}
