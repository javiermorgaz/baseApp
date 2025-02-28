import Dependencies
import Foundation
import NetworkProtocols

struct RegisterClient: Sendable {
    var createUser: @Sendable (_ email: String, _ password: String, _ phone: String) async throws(AuthenticationServiceError) -> Void
    var validateEmail: @Sendable (_ email: String) -> Bool
    var validatePassword: @Sendable (_ password: String) -> Bool
}

extension RegisterClient: DependencyKey {
    static var liveValue: Self {
        @Dependency(\.dependencies.authenticationService) var authenticationService
        
        return .init(
            createUser: { email, password, phone throws(AuthenticationServiceError) in
                try await authenticationService.registerUser(email, password, phone)
            },
            validateEmail: { email in
                validateEmail(email)
            },
            validatePassword: { password in
                validatePassword(password)
            }
        )
    }
    
    static let previewValue = Self(
        createUser: { email, password, phone in
            return
        },
        validateEmail: { email in
            true
        },
        validatePassword: { password in
            true
        }
    )
    
    private static func validateEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private static func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9])[A-Za-z\\d\\S]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}

extension DependencyValues {
    var registerClient: RegisterClient {
        get { self[RegisterClient.self] }
        set { self[RegisterClient.self] = newValue }
    }
}
