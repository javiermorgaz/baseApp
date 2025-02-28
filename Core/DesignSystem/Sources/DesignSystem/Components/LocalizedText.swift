import SwiftUI
import Strings

public extension Text {
    init(localeCatalogKey: String) {
        self.init(LocalizedStringKey(localeCatalogKey), bundle: StringsExporter.bundle)
    }
}
