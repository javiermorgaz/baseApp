import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(Color.primaryColor)
            .fontOnPrimaryWith(size: 14)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(maxWidth: .infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self { .init() }
}

struct ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        Button("Action") {}
            .buttonStyle(.primary)
            .padding()
    }
}
