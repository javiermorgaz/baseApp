import Foundation

public protocol SessionManagerProtocol: Sendable {
    func signUp(email: String, password: String) async throws(SessionManagerError)
    func signIn(email: String, password: String) async throws(SessionManagerError)
    func singOut() async throws
    func isAuthenticated() async throws
    func sessionToken() async -> String
    func user() async throws -> SessionUser
}

public struct SessionUser: Sendable {
    let id: UUID
    let email: String
    
    public init(id: UUID, email: String) {
        self.id = id
        self.email = email
    }
}

public enum SessionManagerError: Error {
    case weakPassword
    case invalidCredentials
    case emailNotConfirmed
    case userNotFound
    case sessionExpired
    case unknown
}
