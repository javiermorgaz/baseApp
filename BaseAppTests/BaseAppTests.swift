import Testing
import ComposableArchitecture
import NetworkProtocols
import OrderedCollections
import SessionProtocols
import Network

@testable import BaseApp

@MainActor
struct BaseAppTests {
    
    @Test func checkAutenticated() async  {
        let store = TestStore(initialState: AppFeature.State(),
                              reducer: { AppFeature() },
                              withDependencies: {
            $0.coreDependencies = getCoreDependencies()
            $0.coreDependencies.authenticationService.isAuthenticated = { return }
        })
        
        #expect(store.state.isLoggedIn == nil)
        await store.send(.checkAuthentication)
        await store.receive(\.isAuthenticated) {
            $0.isLoggedIn = true
        }
    }

    @Test func checkNotAutenticated() async  {
        let store = TestStore(initialState: AppFeature.State(),
                              reducer: { AppFeature() },
                              withDependencies: {
            $0.coreDependencies = getCoreDependencies()
            $0.coreDependencies.authenticationService.isAuthenticated = {
                throw AuthenticationServiceError.unknown
            }
        })
        
        #expect(store.state.isLoggedIn == nil)
        await store.send(.checkAuthentication)
        await store.receive(\.isAuthenticated) {
            $0.isLoggedIn = false
        }
    }
    
    @Test func wellcomeSignInSucces() async  {
        let store = TestStore(initialState: AppFeature.State(),
                              reducer: { AppFeature() })
        
        #expect(store.state.isLoggedIn == nil)
        await store.send(.welcome(.signInSuccess)) {
            $0.isLoggedIn = true
        }
        await store.receive(\.navigate) {
            $0.path[id: 0] = .tabs(TabsFeature.State())
        }
    }
    
    @Test func navigatetoFeature1() async  {
        let store = TestStore(initialState: AppFeature.State(isLoggedIn: true),
                              reducer: { AppFeature() },
                              withDependencies: {
            $0.coreDependencies = getCoreDependencies()
            $0.coreDependencies.authenticationService.logOutUser = { return }
        })
        
        await store.send(.navigate) {
            $0.path[id: 0] = .tabs(TabsFeature.State(selectedTab: .feature1))
        }
    }
    
    @Test func navigateToFeature2() async  {
        let store = TestStore(initialState: AppFeature.State(isLoggedIn: true,
                                                             deepLink: .feature2),
                              reducer: { AppFeature() },
                              withDependencies: {
            $0.coreDependencies = getCoreDependencies()
            $0.coreDependencies.authenticationService.logOutUser = { return }
        })
        
        await store.send(.navigate) {
            $0.path[id: 0] = .tabs(TabsFeature.State(selectedTab: .feature2))
        }
    }
    
    @Test func checkLogout() async  {
        let store = TestStore(initialState: AppFeature.State(path: StackState([.tabs(TabsFeature.State())]),
                                                             isLoggedIn: true),
                              reducer: { AppFeature() },
                              withDependencies: {
            $0.coreDependencies = getCoreDependencies()
            $0.coreDependencies.authenticationService.logOutUser = { return }
        })
        
        #expect(store.state.isLoggedIn == true)
        await store.send(.path(.element(id: 0, action: .tabs(.feature1(.logOutSuccess))))) {
            $0.isLoggedIn = false
            $0.path[id: 0] = nil
        }
    }
    
    private func getCoreDependencies() -> CoreDependencies {
        let sessionManagerMock = SessionManagerMock()
        return CoreDependencies(
            apiClient: DefaultAPIClient(baseURL: URL(string: "www.mock.com")!,
                                        sessionManager: sessionManagerMock),
            sessionManager: sessionManagerMock,
            authenticationService: AuthenticationService.previewValue)
    }
}

extension StackState {
  mutating func assert(_ expected: OrderedDictionary<StackElementID, Element>) {
    for (id, element) in expected {
      guard self[id: id] == nil else { continue }
      self.append(element)
    }
    for removedId in ids.subtracting(expected.keys) {
      self[id: removedId] = nil
    }
  }
}

private final class SessionManagerMock: SessionManagerProtocol {
    func signUp(email: String, password: String)
    async throws(SessionProtocols.SessionManagerError) {}
    
    func signIn(email: String, password: String)
    async throws(SessionProtocols.SessionManagerError) {}
    
    func singOut() async throws {}
    
    func isAuthenticated() async throws {}
    
    func sessionToken() async -> String { "" }
    
    func user() async throws -> SessionProtocols.SessionUser {
        SessionUser(id: .init(), email: "")
    }
}
