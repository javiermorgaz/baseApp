import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct ErrorScreen: View {
    let store: StoreOf<ErrorFeature>
    
    public init(store: StoreOf<ErrorFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            VStack(spacing: Layout.Spacing.medium) {
                Text(localeCatalogKey: store.title)
                    .lineLimit(2)
                    .bold()
                    .fontOnSecondaryWith(size: Layout.FontSize.title)
                Text(localeCatalogKey: store.body)
                    .lineLimit(3)
                    .fontOnSecondaryWith(size: Layout.FontSize.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
            Button() {
                store.send(.closeTapped)
            } label: {
                Text(localeCatalogKey: store.buttonTitle)
            }
            .buttonStyle(PrimaryButtonStyle.primary)
        }
        .background(Color.primaryBackgroundColor)
        .padding(Layout.Spacing.large)
        .presentationDetents([.height(250)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    ErrorScreen(store: Store(initialState:
                                ErrorFeature.State(title: "Login failed",
                                                   body: "Your account is created, but your email is not confirmed. Check your inbox to activate your account.",
                                                   buttonTitle: "Ok"),
                             reducer: {
        ErrorFeature()
    }))
}
