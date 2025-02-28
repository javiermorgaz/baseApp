import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct Feature2Screen: View {

    @Bindable var store: Store<Feature2Feature.State, Feature2Feature.Action>

    public init(store: Store<Feature2Feature.State, Feature2Feature.Action>) {
        self.store = store
    }

    public var body: some View {
        VStack{
            Text("Feature 2")
        }
        .padding(.horizontal)
        .background(Color.primaryBackgroundColor)
    }
}

#Preview {
    Feature2Screen(store:
                Store(initialState: Feature2Feature.State()) {
        Feature2Feature()
    })
}
