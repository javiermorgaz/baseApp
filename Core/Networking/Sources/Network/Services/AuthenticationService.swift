import Foundation
import Dependencies
import NetworkingProtocols
import SessionProtocols

public struct AuthenticationService: AuthenticationServiceProtocol {
    public var isAuthenticated: @Sendable () async throws -> Void
    public var registerUser: @Sendable (_ email: String, _ password: String, _ phone: String) async throws(AuthenticationServiceError) -> Void
    public var logInUser: @Sendable (_ email: String, _ password: String) async throws(AuthenticationServiceError) -> Void
    public var logOutUser: @Sendable () async throws -> Void
}

extension AuthenticationService: DependencyKey {
    public static var liveValue: Self {
        return .init(
            isAuthenticated: {
                try await isAuthenticated()
            }, registerUser: { email, password, phone throws(AuthenticationServiceError) in
                try await registerUser(email: email, password: password, phone: phone)
            }, logInUser: { email, password throws(AuthenticationServiceError) in
                try await logInUser(email: email, password: password)
            }, logOutUser: {
                try await logOutUser()
            }
        )
    }
    
    public static let previewValue = Self(
        isAuthenticated: {
            throw AuthenticationServiceError.unknown
            // Uncomment here to validate session (throws an error if not authenticated)
            //return
        }, registerUser: { email, password, phone throws(AuthenticationServiceError) in
            return
        }, logInUser: { email, password throws(AuthenticationServiceError) in
            return
        }, logOutUser: {
            return
        }
    )
    
    public static func isAuthenticated() async throws {
        @Dependency(\.dependencies.sessionManager) var sessionManager
        try await sessionManager.isAuthenticated()
        try await logInInternalService()
    }
    
    public static func registerUser(email: String, password: String, phone: String) async throws(AuthenticationServiceError) {
        @Dependency(\.dependencies.apiClient) var apiClient
        @Dependency(\.dependencies.sessionManager) var sessionManager
        
        struct RegisterRequest: Encodable {
            let name: String
            let surname: String
            let phone: String
        }
        
        do {
            try await sessionManager.signUp(email: email, password: password)
            try await apiClient.fetchVoid(
                APIRequest.jsonRequest(endpoint: "v1/auth/register",
                                       method: .post,
                                       body: RegisterRequest(name: "John",
                                                             surname: "Denver",
                                                             phone: "+34666666666"))
            )
        } catch let error as SessionManagerError {
            throw AuthenticationServiceError.map(from: error)
        } catch let error as APIClientError {
            print("🔒 Error during sign-up in internal server")
            throw AuthenticationServiceError.map(from: error)
        } catch {
            throw .unknown
        }
    }
    
    public static func logInUser(email: String, password: String) async throws(AuthenticationServiceError) {
        @Dependency(\.dependencies.sessionManager) var sessionManager

        do {
            try await sessionManager.signIn(email: email, password: password)
            try await logInInternalService()
        } catch let error as SessionManagerError {
            throw AuthenticationServiceError.map(from: error)
        } catch let error as APIClientError {
            throw AuthenticationServiceError.map(from: error)
        } catch {
            throw .unknown
        }
    }
    
    public static func logOutUser() async throws {
        @Dependency(\.dependencies.sessionManager) var sessionManager

        try await sessionManager.singOut()
    }
    
    private static func logInInternalService() async throws {
        @Dependency(\.dependencies.apiClient) var apiClient

        do {
            try await apiClient.fetchVoid(
                APIRequest(endpoint: "v1/auth/login", method: .post)
            )
            print("🔒 Sign-in successful in internal server")
        } catch {
            print("🔒 Error during sign-in in internal server")
            throw error
        }
    }
}

extension DependencyValues {
    var service: AuthenticationService {
        get { self[AuthenticationService.self] }
        set { self[AuthenticationService.self] = newValue }
    }
}

extension AuthenticationServiceError {
    static func map(from error: SessionManagerError) -> AuthenticationServiceError {
        switch error {
        case .weakPassword:
            return .weakPassword
        case .invalidCredentials:
            return .invalidCredentials
        case .emailNotConfirmed:
            return .emailNotConfirmed
        case .userNotFound:
            return .userNotFound
        case .sessionExpired:
            return .sessionExpired
        default:
            return .unknown
        }
    }
    
    static func map(from error: APIClientError) -> AuthenticationServiceError {
        switch error {
        case .unauthorized:
            return .sessionExpired
        default:
            return .unknown
        }
    }
}
