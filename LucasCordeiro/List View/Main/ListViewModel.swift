//
//  ListViewModel.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 15/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Foundation

class ListViewModel: NSObject {

    //
    // MARK: - Local Properties -
    private var newsList: [News] = []

    private var hasPagination = false

    private var pageSize = 2

    private var page = 1

    private var sourceId: String?

    init(sourceId: String) {
        super.init()

        self.sourceId = sourceId
    }

    //
    // MARK: - News Method -
    /// Get list of news
    ///
    /// - Parameters:
    ///   - completion: returns 'success'property and 'errorMessage' if appliable
    func listNews(completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void) {

        hasPagination = true
        APIClient.listNews(pageSize: pageSize,
                           page: page,
                           sourceId: sourceId) { [weak self] (result) in
            guard let strongSelf = self else {
                completion(false, "Reference error")
                return
            }
            var success = false
            var errorMessage: String?

            if let validResult = try? result.unwrap() {
                let totalResults = validResult.totalResults ?? 0
                strongSelf.hasPagination = strongSelf.page < strongSelf.pageCount(totalResult: totalResults)

                if let articles = validResult.articles {
                    strongSelf.newsList.append(contentsOf: articles)
                    success = true
                }
            } else {
                errorMessage = "Service error. Try to verify listNews methods."
            }

            completion(success, errorMessage)
        }
    }

    func paginateNews(completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void) {
        if hasPagination {
            page += 1
            APIClient.listNews(pageSize: pageSize,
                               page: page,
                               sourceId: sourceId) { [weak self] (result) in
                                guard let strongSelf = self else {
                                    completion(false, "Reference error")
                                    return
                                }
                                var success = false
                                var errorMessage: String?

                                if let validResult = try? result.unwrap() {
                                    let totalResults = validResult.totalResults ?? 0
                                    strongSelf.hasPagination =
                                        strongSelf.page < strongSelf.pageCount(totalResult: totalResults)

                                    if let articles = validResult.articles, articles.count > 0 {
                                        strongSelf.newsList.append(contentsOf: articles)
                                    } else {
                                        strongSelf.hasPagination = false
                                    }
                                    success = true
                                } else {
                                    strongSelf.hasPagination = false

                                    errorMessage = "Service error. Try to verify listNews methods."
                                }

                                completion(success, errorMessage)
            }
        }
    }

    /// Get the number of News Sections
    ///
    /// - Returns: number of list section
    func numberOfSection() -> Int {
        return hasPagination ? 2 : 1
    }

    /// Get the number of News in a 'section'
    ///
    /// - Parameter section: where News count is within
    /// - Returns: count with number of News
    func numberOfRows(inSection section: Int) -> Int {
        return section == 0 ? newsList.count : 1
    }

    /// Get title of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' title
    func newsTitle(at indexPath: IndexPath) -> String {
        return newsList.count > indexPath.row ? newsList[indexPath.row].title ?? "Title Not Found" : "Title Not Found"
    }

    /// Get description of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' description
    func newsDescription(at indexPath: IndexPath) -> String {
        return newsList.count > indexPath.row ?
            newsList[indexPath.row].newsDescription ?? "Description Not Found" : "Description Not Found"
    }

    /// Get description of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' description
    func newsDate(at indexPath: IndexPath) -> String {
        guard let date = newsList.count > indexPath.row ? newsList[indexPath.row].publishedAt : nil else {
            return "Date Not Found"
        }

        let onlyDate = String(date.split(separator: "T").first ?? "")
        let dateFormatted = onlyDate.convertDate(fromFormat: "yyyy-MM-dd", toFormat: "MM/dd/yyyy")

        return dateFormatted ?? "Date Not Found"
    }

    /// Get description of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' description
    func newsSourceName(at indexPath: IndexPath) -> String {
        return newsList.count > indexPath.row ?
            newsList[indexPath.row].source?.name  ?? "Source Not Found" : "Source Not Found"
    }

    /// Get thumbnail URL of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' thumbnail URL
    func newsThumbUrl(at indexPath: IndexPath) -> URL? {
        let urlStringToImage = newsList.count > indexPath.row ? newsList[indexPath.row].urlToImage ?? "" : ""
        let url = URL(string: urlStringToImage)

        return url
    }

    //
    // MARK: - Auxiliar Methods -
    func isLoadingSection(at indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }

    //
    // MARK: - Auxiliar Local Methods -
    private func pageCount(totalResult: Int) -> Int {
        var pageCount = Float(totalResult/pageSize)
        pageCount.round(.up)

        return Int(pageCount)
    }
}
