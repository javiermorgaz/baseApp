import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct RegisterScreen: View {
    
    @Bindable private var store: StoreOf<RegisterFeature>
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool

    public init(store: StoreOf<RegisterFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path,
                                           action: \.path)
        ) {
            VStack(spacing: 0) {
                header
                    .frame(maxHeight: 150)
                    .background(Color.primaryColor)
                form
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primaryBackgroundColor)
            }
            .onTapGesture {
                hideKeyboard()
            }
        } destination: { store in
            switch store.case {
            case .confirmation(let store):
                ConfirmationScreen(store: store)
            }
        }
        .interactiveDismissDisabled(true)
    }
    
    private var header: some View {
        HStack {
            VStack (alignment: .leading) {
                Spacer()
                Text(localeCatalogKey: "Feature.Register.Title")
                    .bold()
                    .fontOnPrimaryWith(size: 32)
                
                Spacer().frame(height: Layout.Spacing.medium)
                HStack {
                    Text(localeCatalogKey: "Feature.Register.Subtitle")
                        .fontOnPrimaryWith(size: 12)
                    Button(action: {
                        store.send(.signInTapped)
                    }) {
                        Text(localeCatalogKey: "Feature.Register.Subtitle.Button.Login")
                            .fontOnPrimaryWith(size: 12)
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
        HStack{
            VStack {
                VStack {
                    Text(localeCatalogKey: "Feature.Welcome.Form.Field.Email")
                        .fontOnSecondaryLightWith(size: 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FormTextField(text: $store.email.sending(\.emailUpdated),
                                  isFocused: $isEmailFocused,
                                  keyBoardType: .emailAddress)
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
                        .fontOnSecondaryLightWith(size: 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FormSecureField(text: $store.password.sending(\.passWordUpdated),
                                    isFocused: $isPasswordFocused)
                    Text(store.passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(height: 40)
                }
                
                Spacer().frame(height: Layout.Spacing.extraLarge)
                Button() {
                    store.send(.signUpTapped)
                } label: {
                    Text(localeCatalogKey:"Feature.Register.Form.Button.Register")
                }
                .buttonStyle(PrimaryButtonStyle.primary)

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
    RegisterScreen(store:
                Store(initialState: RegisterFeature.State()) {
        RegisterFeature()
    })
}

