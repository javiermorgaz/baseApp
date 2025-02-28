import Foundation
import SwiftUI

public struct StringsExporter {
  public static var bundle: Bundle { Bundle.module }
}

public extension String {
    init(localeCatalogKey: String.LocalizationValue) {
        self.init(localized: localeCatalogKey, bundle: StringsExporter.bundle)
    }
}
