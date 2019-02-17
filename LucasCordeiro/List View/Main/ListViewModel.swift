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

    private var pageSize = 10

    private var page = 0

    private var country = "us"

    //
    // MARK: - News Method -
    /// Get list of news
    ///
    /// - Parameters:
    ///   - completion: returns 'success'property and 'errorMessage' if appliable
    func listNews(completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void) {

        APIClient.listNews(country: country, pageSize: pageSize, page: page) { [weak self] (result) in
            guard let strongSelf = self else {
                completion(false, "Reference error")
                return
            }
            var success = false
            var errorMessage: String?

            if let validResult = try? result.unwrap() {
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

    /// Get the number of News Sections
    ///
    /// - Returns: number of list section
    func numberOfSection() -> Int {
        return 1
    }

    /// Get the number of News in a 'section'
    ///
    /// - Parameter section: where News count is within
    /// - Returns: count with number of News
    func numberOfRows(inSection section: Int) -> Int {
        return newsList.count
    }

    /// Get title of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' title
    func newsTitle(at indexPath: IndexPath) -> String? {
        return newsList.count > indexPath.row ? newsList[indexPath.row].title : nil
    }

    /// Get description of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' description
    func newsDescription(at indexPath: IndexPath) -> String? {
        return newsList.count > indexPath.row ? newsList[indexPath.row].newsDescription : nil
    }

    /// Get description of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' description
    func newsDate(at indexPath: IndexPath) -> String? {
        guard let date = newsList.count > indexPath.row ? newsList[indexPath.row].publishedAt : nil else {
            return nil
        }

        let onlyDate = String(date.split(separator: "T").first ?? "")
        let dateFormatted = onlyDate.convertDate(fromFormat: "yyyy-MM-dd", toFormat: "MM/dd/yyyy")

        return dateFormatted
    }

    /// Get description of a news
    ///
    /// - Parameter indexPath: position of news on tableView
    /// - Returns: news' description
    func newsSourceName(at indexPath: IndexPath) -> String? {
        return newsList.count > indexPath.row ? newsList[indexPath.row].source?.name : nil
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
}
