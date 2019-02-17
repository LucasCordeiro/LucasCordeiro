//
//  APIClient.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 15/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Alamofire

/// Class that willl provide services to view models
class APIClient {

    /// Perform request with information
    ///
    /// - Parameters:
    ///   - route: route/path
    ///   - decoder: decoder (JSONDecoder as default)
    ///   - completion: completion called after finishing request
    /// - Returns: DataRequest
    @discardableResult
    private static func performRequest<T: Decodable>(route: APIRouter,
                                                     decoder: JSONDecoder = JSONDecoder(),
                                                     completion: @escaping (Result<T>) -> Void) -> DataRequest {
        /*
         let manager = Alamofire.SessionManager.default
         manager.session.configuration.timeoutIntervalForRequest = 120
         */
        return Alamofire.Session.default.request(route)
            .responseDecodable (decoder: decoder) { (response: DataResponse<T>) in
                completion(response.result)
        }
    }

    /// Get news from API
    ///
    /// - Parameters:
    ///   - completion: completion called after finishing request
    static func listNews(country: String,
                         pageSize: Int,
                         page: Int,
                         completion: @escaping (Result<NewsResult>) -> Void) {
        let jsonDecoder = JSONDecoder()
        let route = APIRouter.listNews(country: country, pageSize: pageSize, page: page)

        performRequest(route: route, decoder: jsonDecoder, completion: completion)
    }

    /// Get source from API
    ///
    /// - Parameters:
    ///   - completion: completion called after finishing request
    static func listSources(country: String, completion: @escaping (Result<NewsSourceResult>) -> Void) {
        let jsonDecoder = JSONDecoder()
        let route = APIRouter.listSources(country: country)

        performRequest(route: route, decoder: jsonDecoder, completion: completion)
    }
}
