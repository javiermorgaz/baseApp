import ComposableArchitecture

@Reducer
public struct Feature1Feature: Sendable {
    
    @Dependency(\.feature1Client) var feature1Client

    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public init() {}
    
    public enum Action {
        case logOutButtonTapped
        case logOutSuccess
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .logOutButtonTapped:
                return .run { send in
                    do {
                        try await feature1Client.logOutUser()
                        await send(.logOutSuccess)
                    } catch {
                        try await feature1Client.logOutUser()
                    }
                }
            case .logOutSuccess:
                return .none
            }
        }
    }
}
