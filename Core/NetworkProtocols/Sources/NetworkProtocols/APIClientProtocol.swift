import Foundation

public protocol APIClientProtocol: Sendable {
    func fetch<T: Decodable>(_ request: APIRequestProtocol) async throws(APIClientError) -> T
    func fetchVoid(_ request: APIRequestProtocol) async throws(APIClientError)
}

public protocol APIRequestProtocol {
    var endpoint: String { get set }
    var method: HTTPMethod { get set }
    var headers: [String: String]? { get set }
    var body: Data? { get set }
    var queryItems: [URLQueryItem]? { get set }

    init(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        queryItems: [URLQueryItem]?
    )
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum APIClientError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthorized
    case decodingError(Error)
    case networkError(Error)
    case unknown(Int)

    public var errorDescription: String {
        switch self {
        case .invalidURL:
            return "🌍❌ The provided URL is not valid."
        case.invalidResponse:
            return "🌍❌ Invalid response."
        case .unauthorized:
            return "🌍❌ Authentication error"
        case let .decodingError(error):
            return "🌍❌ Error decoding the data: \(error)"
        case let .networkError(error):
            return mapNetworkErrorToDescription(error)
        case .unknown(let statusCode):
            return "🌍❌ Unknown error, status code: \(statusCode)"
        }
    }
    
    private func mapNetworkErrorToDescription(_ error: Error) -> String {
        if let urlError = error as? URLError {
            let errorDetails = "Code: \(urlError.code.rawValue), Domain: \(urlError.errorCode)"
            
            switch urlError.code {
            case .notConnectedToInternet:
                return "🌍❌ The device is not connected to the internet. (\(errorDetails))"
            case .timedOut:
                return "🌍❌ The request timed out. (\(errorDetails))"
            case .cannotFindHost:
                return "🌍❌ The host could not be found. (\(errorDetails))"
            case .cannotConnectToHost:
                return "🌍❌ Unable to connect to the host. (\(errorDetails))"
            case .networkConnectionLost:
                return "🌍❌ The network connection was lost. (\(errorDetails))"
            default:
                return "🌍❌ An unknown network error occurred. (\(errorDetails))"
            }
        } else {
            return "🌍❌ An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}
