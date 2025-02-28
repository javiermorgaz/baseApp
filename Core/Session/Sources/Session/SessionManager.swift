import SessionProtocols
import Foundation

public final class SessionManager: SessionManagerProtocol {

    private let sessionManagerProvider: SessionManagerProviderProtocol
    private let sessionTokenStorage = TokenStorage()
    
    public init() {
        self.sessionManagerProvider = SessionManagerProvider(sessionTokenStorage: sessionTokenStorage)
    }
    
    public func user() async throws -> SessionUser {
        try await sessionManagerProvider.user()
    }

    public func sessionToken() async -> String {
        let expiresIn = await sessionTokenStorage.expiresIn
        await refreshTokenIfNeeded(expiresIn)
        return await sessionTokenStorage.fetch()
    }
    
    public func isAuthenticated() async throws {
        do {
            try await sessionManagerProvider.isAuthenticated()
        } catch {
            print("🔒 Session not available in provider: \(error)")
            throw error
        }
    }
    
    public func signUp(email: String, password: String) async throws(SessionManagerError) {
        do {
            try await sessionManagerProvider.signUp(email: email, password: password)
            print("🔒 Sign-up successful for email in provider: \(email)")
        } catch {
            print("🔒 Error during sign-up in provider: \(error)")
            throw error
        }
    }
    
    public func signIn(email: String, password: String) async throws(SessionManagerError) {
        do {
            try await sessionManagerProvider.signIn(email: email, password: password)
            print("🔒 Sign-in successful for email in provider: \(email)")
        } catch {
            print("🔒 Error during sign-in in provider: \(error)")
            throw error
        }
    }
    
    public func singOut() async throws {
        do {
            try await sessionManagerProvider.singOut()
            print("🔒 Sign-out successful in provider")
        } catch {
            print("🔒 Error during sign-out in provider: \(error)")
            throw error
        }
    }
    
    func refreshTokenIfNeeded(_ expiresIn: TimeInterval) async {
        let currentTime = Date().timeIntervalSince1970
        let expirationTime = currentTime + expiresIn
        
        // Refresh token if it is expired or will expire within 30 seconds
        if expirationTime - currentTime <= 30 {
            do {
                let newTokenData = try await retrieveNewToken()
                await sessionTokenStorage.update(token: newTokenData.newToken,
                                                                 expiresIn: newTokenData.expiresIn)
            } catch {
                print("🔒 Failed to refresh token in provider: \(error)")
            }
        }
    }

    private func retrieveNewToken() async throws -> (newToken: String, expiresIn: TimeInterval) {
        try await sessionManagerProvider.refreshToken()
    }
}

actor TokenStorage: Sendable {
    private var token: String = ""
    var expiresIn: TimeInterval = 0.0

    func update(token: String,
                expiresIn: TimeInterval) {
        self.token = token
        self.expiresIn = expiresIn
    }

    func fetch() -> String {
        
        token
    }
}
