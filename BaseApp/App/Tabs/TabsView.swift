import SwiftUI
import ComposableArchitecture
import Feature1
import Feature2

struct TabsView: View {
    
    @Bindable var store: StoreOf<TabsFeature>
    
    var body: some View {
        TabView(selection: $store.selectedTab) {
            Feature1Screen(store: store.scope(state: \.feature1, action: \.feature1))
                .tabItem {
                    Text("Feature1")
                }.tag(TabsFeature.State.Tab.feature1)
            
            Feature2Screen(store: store.scope(state: \.feature2, action: \.feature2))
                .tabItem {
                    Text("Feature2")
                }.tag(TabsFeature.State.Tab.feature2)
        }
        .navigationBarBackButtonHidden(true)
    }
}

