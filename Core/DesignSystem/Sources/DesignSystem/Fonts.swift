import SwiftUI

public struct FontWithSizeAndColor: ViewModifier {
    let size: CGFloat
    let color: Color

    public func body(content: Content) -> some View {
        content
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

public extension View {
    func fontOnPrimaryWith(size: CGFloat) -> some View {
        self.modifier(FontWithSizeAndColor(size: size, color: .onPrimaryColor))
    }
    
    func fontOnSecondaryWith(size: CGFloat) -> some View {
        self.modifier(FontWithSizeAndColor(size: size, color: .onSecondaryColor))
    }
    
    func fontOnSecondaryLightWith(size: CGFloat) -> some View {
        self.modifier(FontWithSizeAndColor(size: size, color: .onPrimaryLightColor))
    }
}
