//
//  NetworkManager.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 21/12/24.
//

import Foundation

//MARK: - NetworkManager
class NetworkManager {

    static let shared = NetworkManager()
    
    var baseHeaders = [
        "Accept": "application/json",
        "x-cg-demo-api-key": "CG-cJ9DXGT7CkNkqRdM73CxJEtb"
    ]

    private init() {}

    func perform<T: Decodable>(_ api: any API) async throws -> T {
        guard let url = api.url else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = api.method.rawValue

        baseHeaders.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        api.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        if let body = api.bodyRequest {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}

//MARK: - API
protocol API {
    associatedtype Output
    
    var path: String { get set }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var bodyRequest: Data? { get }
    var url: URL? { get }
}

extension API {

    var url: URL? {
        var components = URLComponents(string: "https://api.coingecko.com/api/v3")!
        components.path += path
        components.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url
    }
    
    func getRequest(adding bodyRequest: Encodable) -> any API {
        let bodyData = try? JSONEncoder().encode(bodyRequest)
        return GetCryptoListAPI(path: path,
                                method: method,
                                headers: headers,
                                queryParameters: queryParameters,
                                bodyRequest: bodyData)
    }
    
}

//MARK: - HTTPMethod
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

