import Foundation
import SessionProtocols

protocol SessionManagerProviderProtocol: Sendable {
    func isAuthenticated() async throws
    func signUp(email: String, password: String) async throws(SessionManagerError)
    func signIn(email: String, password: String) async throws(SessionManagerError)
    func singOut() async throws
    func refreshToken() async throws -> (newToken: String, expiresIn: TimeInterval)
    func user() async throws -> SessionUser
}

final class SessionManagerProvider: SessionManagerProviderProtocol {
    
    //private let client = Client()
    
    private let sessionTokenStorage: TokenStorage
    
    init(sessionTokenStorage: TokenStorage) {
        self.sessionTokenStorage = sessionTokenStorage
        Task {
             await subscribeToSessionUpdates()
         }
    }
    
    func user() async throws -> SessionUser {
        /*     do {
            
        } catch let error {
            throw SessionManagerError.map(from: error)
        } */
        return SessionUser(id: UUID(),
                           email: "")
    }
        
    func isAuthenticated() async throws(SessionManagerError) {
        /*     do {
            
        } catch let error {
            throw SessionManagerError.map(from: error)
        } */
    }
    
    func signUp(email: String, password: String) async throws(SessionManagerError) {
        /*       do {

        } catch let error {
            throw SessionManagerError.map(from: error)
        } */
    }
    
    func signIn(email: String, password: String) async throws(SessionManagerError) {
        /*       do {

        } catch let error {
            throw SessionManagerError.map(from: error)
        } */
    }
    
    func singOut() async throws {
        /*       do {

        } catch let error {
            throw SessionManagerError.map(from: error)
        } */
    }
    
    func refreshToken() async throws -> (newToken: String, expiresIn: TimeInterval) {
        /*     do {
            
        } catch let error {
            throw SessionManagerError.map(from: error)
        } */
        return ("TOKEN", 0.0)
    }
       
    private func subscribeToSessionUpdates() async {
        /*     do {
            
        } catch let error {
            throw SessionManagerError.map(from: error)
        } */
    }
       
}

extension SessionManagerError {
    static func map(from error: Error) -> SessionManagerError {
        return .unknown
    }
}
