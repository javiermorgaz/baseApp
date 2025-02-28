import ComposableArchitecture

public extension Effect {
    func debounce(id: some Hashable & Sendable) -> Self {
        let debounceSeconds = 0.5
        @Dependency(\.mainQueue) var mainQueue

        return debounce(id: id, for: .seconds(debounceSeconds), scheduler: mainQueue)
    }
}
