//
//  APIServiceProvider.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol URLRequestProtocol {
    func returnURLRequest() throws -> URLRequest
}

open class APIServiceProvider<T: Codable>: URLRequestProtocol {
    private var method: HTTPMethod
    private var baseURL: String
    private var path: String?
    private var data: T?

    public init(method: HTTPMethod,
                baseURL: String,
                path: String? = nil,
                data: T? = nil) {
        self.method = method
        self.baseURL = baseURL
        self.path = path
        self.data = data
    }

    public func returnURLRequest() throws -> URLRequest {
        var url = try baseURL.url()

        if let path = path {
            url = url.appendingPathComponent(path)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        try configureEncoding(request: &request)

        return request
    }

    private func configureEncoding(request: inout URLRequest) throws {
        switch method {
        case .post, .put:
            try ParameterEncoding.jsonEncoding.encode(urlRequest: &request, parameters: params)
        case .get:
            try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
        default:
            try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
        }
    }

    private var params: Parameters? {
        return data.asDictionary()
    }
}
