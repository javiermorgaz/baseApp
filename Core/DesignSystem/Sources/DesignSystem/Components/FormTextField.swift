import SwiftUI

public struct FormTextField: View {
    
    private var placeholder: String
    @Binding private var text: String
    @FocusState.Binding private var isFocused: Bool
    private var keyBoardType: UIKeyboardType
    
    private let fontSize: CGFloat = 16
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 1
    private let height: CGFloat = 46
    private let padding: CGFloat = 8
        
    public init(
        placeholder: String = "",
        text: Binding<String>,
        isFocused: FocusState<Bool>.Binding,
        keyBoardType: UIKeyboardType = .default
    ) {
        self.placeholder = placeholder
        self._text = text
        self._isFocused = isFocused
        self.keyBoardType = keyBoardType
    }
    
    public var body: some View {
        TextField(placeholder, text: $text)
        .font(.system(size: fontSize))
        .focused($isFocused)
        .keyboardType(keyBoardType)
        .padding(padding)
        .frame(height: height)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray, lineWidth: lineWidth)
        )
    }
}


public struct FormSecureField: View {
    
    private let fontSize: CGFloat = 16
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 1
    private let height: CGFloat = 46
    private let padding: CGFloat = 8
    
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false
    @FocusState.Binding private var isFocused: Bool

    public init(
        text: Binding<String>,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self._isFocused = isFocused
    }
    
    public var body: some View {
        HStack {
            if isPasswordVisible {
                TextField("", text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                SecureField("", text: $text)
            }
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
        }
        .font(.system(size: fontSize))
        .focused($isFocused)
        .keyboardType(.default)
        .padding(padding)
        .frame(height: height)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray, lineWidth: lineWidth)
        )
    }
}
