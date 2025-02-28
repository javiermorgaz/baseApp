import ComposableArchitecture

@Reducer
public struct ConfirmationFeature {
    public struct State: Equatable {
        public init() {}
    }
    
    public init() {}
    
    public enum Action {
        case confirmationTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action{
            case .confirmationTapped:
                return .none
            }
        }
    }
}
