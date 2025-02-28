import Register
import Dependencies

extension RegisterDependencies: @retroactive DependencyKey  {
    
    public static var liveValue: Self {
        @Dependency(\.coreDependencies.authenticationService) var authenticationService
        return .init(authenticationService: authenticationService)
    }
}
