import ComposableArchitecture
import Feature1
import Feature2

@Reducer
struct TabsFeature {
    
    @ObservableState
    struct State: Equatable {
        var feature1 = Feature1Feature.State()
        var feature2 = Feature2Feature.State()
        var selectedTab: Tab = .feature1
        
        enum Tab {
            case feature1
            case feature2
        }
    }
    
    enum Action {
        case feature1(Feature1Feature.Action)
        case feature2(Feature2Feature.Action)
        case tabSelected(State.Tab)
    }
    
    var body: some ReducerOf<TabsFeature> {
        Scope(state: \.feature1, action: \.feature1) {
            Feature1Feature()
        }
        Scope(state: \.feature2, action: \.feature2) {
            Feature2Feature()
        }
        Reduce { state, action in
            switch action {
            case .feature1:
                return .none
            case .feature2:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
    }
}

extension StoreOf<TabsFeature> {
    var selectedTab: TabsFeature.State.Tab {
        get { state.selectedTab }
        set { send(.tabSelected(newValue)) }
    }
}
