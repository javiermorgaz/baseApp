import SwiftUI
import ComposableArchitecture
import DesignSystem
import Error

public struct WelcomeScreen: View {
    
    @Bindable private var store: StoreOf<WelcomeFeature>
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    public init(store: StoreOf<WelcomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                header
                    .frame(maxHeight: 220)
                    .background(Color.primaryColor)
                    .onTapGesture {
                        hideKeyboard()
                    }
                form
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primaryBackgroundColor)
                
            }
            if store.state.isLoading {
                FullScreenLoader()
            }
        }
        .sheet(
            item: $store.scope(state: \.errorAlertSignIn, action: \.errorAlertSignIn)
        ) { store in
            ErrorScreen(store: store)
        }
    }
    
    private var header: some View {
        HStack {
            VStack (alignment: .leading) {
                Spacer().frame(height: Layout.Spacing.large)
                HStack {
                    Image.logo
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Base APP")
                        .bold()
                        .fontOnPrimaryWith(size: Layout.FontSize.body)
                }
                Spacer()

                Text(localeCatalogKey: "Feature.Welcome.Title")
                    .lineLimit(2)
                    .bold()
                    .fontOnPrimaryWith(size: Layout.FontSize.largeTitle)
                
                Spacer().frame(height: Layout.Spacing.medium)
                HStack {
                    Text(localeCatalogKey: "Feature.Welcome.Subtitle")
                        .fontOnPrimaryWith(size: Layout.FontSize.caption)
                    Button(action: {
                        store.send(.signUpTapped)
                    }) {
                        Text(localeCatalogKey: "Feature.Welcome.Subtitle.Button")
                            .fontOnPrimaryWith(size: Layout.FontSize.caption)
                            .underline()
                    }
                }

                Spacer().frame(height: Layout.Spacing.extraLarge)
            }
            .padding(.horizontal, Layout.Spacing.large)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
        }
    }
    
    private var form: some View {
        HStack {
            VStack {
                VStack {
                    Text(localeCatalogKey: "Feature.Welcome.Form.Field.Email")
                        .foregroundStyle(Color.gray)
                        .fontOnPrimaryWith(size: Layout.FontSize.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FormTextField(text: $store.email.sending(\.emailUpdated),
                                  isFocused: $isEmailFocused)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    Text(store.emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(height: 20)
                }
                
                Spacer().frame(height: Layout.Spacing.medium)
                
                VStack {
                    Text(localeCatalogKey: "Feature.Welcome.Form.Field.Password")
                        .foregroundStyle(Color.gray)
                        .fontOnPrimaryWith(size: Layout.FontSize.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FormSecureField(text: $store.password.sending(\.passWordUpdated),
                                    isFocused: $isPasswordFocused)
                    Text(store.passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(height: 20)
                }
                
                Spacer().frame(height: Layout.Spacing.extraExtraLarge)
                
                Button() {
                    store.send(.signInTapped)
                } label: {
                    Text(localeCatalogKey: "Feature.Welcome.Form.Button.Continue")
                }
                .buttonStyle(PrimaryButtonStyle.primary)
                Spacer().frame(height: Layout.Spacing.extraLarge)
                
                Text(localeCatalogKey: "Feature.Welcome.Form.Or")
                    .fontOnSecondaryLightWith(size: Layout.FontSize.caption)
                    .foregroundStyle(Color.gray)
                Spacer().frame(height: Layout.Spacing.extraLarge)
                
                .frame(height: 46)
                Spacer()
            }
            .padding(Layout.Spacing.large)
        }
    }
    
    private func hideKeyboard() {
        isEmailFocused = false
        isPasswordFocused = false
    }
}

#Preview {
    WelcomeScreen(store: Store(initialState:
                                WelcomeFeature.State()) {
        WelcomeFeature()
    })
}


