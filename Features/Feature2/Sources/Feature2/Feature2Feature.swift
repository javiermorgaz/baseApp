import ComposableArchitecture

@Reducer
public struct Feature2Feature: Sendable {
    
    @Dependency(\.feature2Client) var feature2Client

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
            return .none
        }
    }
}
