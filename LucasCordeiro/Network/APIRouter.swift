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
    case listNews(country: String, pageSize: Int, page: Int)
    case listSources(country: String)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .listNews,
             .listSources:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .listNews(let country, let pageSize, let page):
            return "top-headlines?country=\(country)&pageSize=\(pageSize)&page=\(page)"
        case .listSources(let country):
            return "sources?country=\(country)"
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .listNews,
             .listSources:
            return nil
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {

        var url: URL

        switch self {
        case .listNews,
             .listSources:
            let urlString = ServerInfo.ServiceServer.newsApiUrl + path +
                ServerInfo.ServiceServer.suffixURL
            url = try urlString.asURL()
        }

        var urlRequest = URLRequest(url: url)

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
