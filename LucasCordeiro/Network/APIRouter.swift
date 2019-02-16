//
//  APIRouter.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 15/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Alamofire

/// API that will provide requests informations
enum APIRouter: URLRequestConvertible {

    // MARK: - Comunication
    case listNews(pageSize: Int, page: Int)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .listNews:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .listNews(let pageSize, let page):
            return "top-headlineslistNews?pageSize=\(pageSize)&page=\(page)" + ServerInfo.ServiceServer.suffixURL
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .listNews:
            return nil
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {

        var url: URL

        switch self {
        case .listNews:
            url = try ServerInfo.ServiceServer.newsApiUrl.asURL()
        }

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
