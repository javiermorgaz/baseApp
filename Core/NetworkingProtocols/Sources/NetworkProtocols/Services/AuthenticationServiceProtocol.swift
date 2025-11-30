public protocol AuthenticationServiceProtocol: Sendable {
    var isAuthenticated: @Sendable () async throws -> Void { get set }
    var registerUser: @Sendable (_ email: String, _ password: String, _ phone: String) async throws(AuthenticationServiceError) -> Void { get set }
    var logInUser: @Sendable (_ email: String, _ password: String) async throws(AuthenticationServiceError) -> Void { get set }
    var logOutUser: @Sendable () async throws -> Void { get set }
}

public enum AuthenticationServiceError: Error {
    case weakPassword
    case invalidCredentials
    case emailNotConfirmed
    case userNotFound
    case sessionExpired
    case unknown
}
