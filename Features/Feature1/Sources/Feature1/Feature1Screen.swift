import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct Feature1Screen: View {

    @Bindable var store: Store<Feature1Feature.State, Feature1Feature.Action>

    public init(store: Store<Feature1Feature.State, Feature1Feature.Action>) {
        self.store = store
    }

    public var body: some View {
        VStack{
            Text("Feature 1")

            Button(action: {
                store.send(.logOutButtonTapped)
            }) {
                Text("Log out")
                    .foregroundColor(.red)
            }
            
        }
        .padding(.horizontal)
        .background(Color.primaryBackgroundColor)
    }
}

#Preview {
    Feature1Screen(store:
                Store(initialState: Feature1Feature.State()) {
        Feature1Feature()
    })
}
