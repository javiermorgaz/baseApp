import Foundation
import NetworkProtocols
import SessionProtocols

public struct APIRequest: APIRequestProtocol {
    public var endpoint: String
    public var method: HTTPMethod
    public var headers: [String: String]?
    public var body: Data?
    public var queryItems: [URLQueryItem]?
    
    public init(
        endpoint: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Data? = nil,
        queryItems: [URLQueryItem]? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
    }
}

extension APIRequest {
    static func jsonRequest<T: Encodable>(
        endpoint: String,
        method: HTTPMethod,
        body: T,
        headers: [String: String]? = nil,
        queryItems: [URLQueryItem]? = nil
    ) throws -> APIRequest {
        let bodyData = try JSONEncoder().encode(body)
        var jsonHeaders = headers ?? [:]
        jsonHeaders["Content-Type"] = "application/json"
        
        return APIRequest(
            endpoint: endpoint,
            method: method,
            headers: jsonHeaders,
            body: bodyData,
            queryItems: queryItems
        )
    }
}

public final class DefaultAPIClient: APIClientProtocol {
    private let baseURL: URL
    private let session: URLSession
    private let sessionManager: SessionManagerProtocol
    
    public init(baseURL: URL,
                sessionManager: SessionManagerProtocol) {
        self.baseURL = baseURL
        self.sessionManager = sessionManager
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: configuration)
    }
}

extension DefaultAPIClient {
    public func fetch<T: Decodable>(_ request: APIRequestProtocol) async throws(APIClientError) -> T {
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(request.endpoint),
                                                resolvingAgainstBaseURL: true) else {
            throw .invalidURL
        }
        
        if let queryItems = request.queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw APIClientError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        var headers = request.headers ?? [:]
        let token = await sessionManager.sessionToken()
        headers["Authorization"] = "Bearer \(token)"
        urlRequest.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIClientError.invalidResponse
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                let apiError = try JSONDecoder().decode(APIDetailError.self, from: data)
                throw mapHTTPStatusCode(httpResponse.statusCode, apiError: apiError)
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw APIClientError.decodingError(error)
            }
        } catch let error as APIClientError {
            print(error.errorDescription)
            throw error
        } catch {
            let netWorkError = APIClientError.networkError(error)
            print(netWorkError.errorDescription)
            throw netWorkError
        }
    }
    
    public func fetchVoid(_ request: APIRequestProtocol) async throws(APIClientError) {
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(request.endpoint),
                                                resolvingAgainstBaseURL: true) else {
            throw .invalidURL
        }

        if let queryItems = request.queryItems {
            urlComponents.queryItems = queryItems
        }

        guard let url = urlComponents.url else {
            throw .invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        var headers = request.headers ?? [:]
        let token = await sessionManager.sessionToken()
        headers["Authorization"] = "Bearer \(token)"
        urlRequest.allHTTPHeaderFields = headers

        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIClientError.invalidResponse
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                let apiError = try JSONDecoder().decode(APIDetailError.self, from: data)
                throw mapHTTPStatusCode(httpResponse.statusCode, apiError: apiError)
            }
        } catch let error as APIClientError {
            print(error.errorDescription)
            throw error
        } catch {
            let netWorkError = APIClientError.networkError(error)
            print(netWorkError.errorDescription)
            throw netWorkError
        }
    }
    
    private func mapHTTPStatusCode(_ statusCode: Int,
                                   apiError: APIDetailError?) -> APIClientError {
        switch statusCode {
        case 401:
            return .unauthorized
        default:
            return .unknown(statusCode)
        }
    }
}

private struct APIDetailError: Decodable {
    let error: String
    let details: String?
}
