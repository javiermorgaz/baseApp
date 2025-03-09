import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct Feature2Screen: View {

    @Bindable var store: StoreOf<Feature2Feature>

    public init(store: StoreOf<Feature2Feature>) {
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
