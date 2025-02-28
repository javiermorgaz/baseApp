import ComposableArchitecture

@Reducer
public struct ErrorFeature {
    
    @ObservableState
    public struct State: Equatable {
        var title: String
        var body: String
        var buttonTitle: String
        
        public init(title: String, body: String, buttonTitle: String) {
            self.title = title
            self.body = body
            self.buttonTitle = buttonTitle
        }
    }
    
    public init() {}
    
    public enum Action {
        case closeTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .closeTapped:
                return .none
            }
        }
    }
}
