import SwiftUI
import ComposableArchitecture
import DesignSystem

struct ConfirmationScreen: View {
    private var store: StoreOf<ConfirmationFeature>

    public init(store: StoreOf<ConfirmationFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(localeCatalogKey: "Feature.Register.Confimation.Body")
                .fontOnSecondaryWith(size: Layout.FontSize.body)
            Spacer()
            Button() {
                store.send(.confirmationTapped)
            } label: {
                Text(localeCatalogKey: "Feature.Register.Confimation.Button.Ok")
            }
            .buttonStyle(PrimaryButtonStyle.primary)
        }
        .padding(Layout.Spacing.large)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ConfirmationScreen(store: Store(initialState: ConfirmationFeature.State(),
                                    reducer: {
        ConfirmationFeature()
    }))
}
