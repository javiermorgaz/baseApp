import SwiftUI

public struct FullScreenLoader: View {
    
    public enum LoaderType {
        case transparent
        case opaque
    }
    
    private var type: LoaderType
    
    public init(type: LoaderType = .transparent) {
        self.type = type
    }
    
    public var body: some View {
        VStack {
            switch type {
            case .transparent:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.onPrimaryColor)
                    .padding()
                    .font(.headline)
            case .opaque:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.onPrimaryColor)
                    .padding()
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(type == .opaque ?
                    Color.primaryColor.ignoresSafeArea()
                    : Color.primaryColor.opacity(0.25).ignoresSafeArea())
    }
}
