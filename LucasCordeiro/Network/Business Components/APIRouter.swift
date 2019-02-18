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
    case listNews(pageSize: Int, page: Int, sourceId: String?)
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
        case .listNews(let pageSize, let page, let sourceId):
            return ServerInfo.isStub
                ? "listNews"
                : "top-headlines?&pageSize=\(pageSize)&page=\(page)" +
                (sourceId != nil ? "&sources=\(sourceId ?? "")" : "")
        case .listSources(let country):
            return ServerInfo.isStub
            ? "listSources"
            : "sources?country=\(country)"
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
        case .listNews:
            let urlString = ServerInfo.isStub
                ? "listNews"
                : ServerInfo.ServiceServer.newsApiUrl + path +
                ServerInfo.ServiceServer.suffixURL
            url = try urlString.asURL()
        case .listSources:
            let urlString = ServerInfo.isStub
                ? "listSources"
                : ServerInfo.ServiceServer.newsApiUrl + path +
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
