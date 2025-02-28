import Foundation

public enum Layout {
    public enum Spacing {
        public static let tiny: CGFloat = 4
        public static let small: CGFloat = 8
        public static let medium: CGFloat = 16
        public static let large: CGFloat = 24
        public static let extraLarge: CGFloat = 32
        public static let extraExtraLarge: CGFloat = 64
    }

    public enum CornerRadius {
        public static let small: CGFloat = 6
        public static let medium: CGFloat = 8
    }

    public enum FontSize {
        public static let largeTitle: CGFloat = 32
        public static let title: CGFloat = 24
        public static let body: CGFloat = 16
        public static let caption: CGFloat = 12
    }

    public enum IconSize {
        public static let small: CGFloat = 20
    }
}
