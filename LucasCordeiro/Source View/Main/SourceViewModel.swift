//
//  SourceViewModel.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit

class SourceViewModel: NSObject {

    //
    // MARK: - Local Properties -
    private var sourceList: [NewsSource] = []

    private var country = "us"

    //
    // MARK: - Sources Method -
    /// Get list of news
    ///
    /// - Parameters:
    ///   - completion: returns 'success'property and 'errorMessage' if appliable
    func listSource(completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void) {

    }

    /// Get the number of sources Sections
    ///
    /// - Returns: number of list section
    func numberOfSection() -> Int {
        return 1
    }

    /// Get the number of sources in a 'section'
    ///
    /// - Parameter section: where sources count is within
    /// - Returns: count with number of sources
    func numberOfRows(inSection section: Int) -> Int {
        return sourceList.count
    }

    /// Get title of a source
    ///
    /// - Parameter indexPath: position of source on tableView
    /// - Returns: source's name
    func sourceName(at indexPath: IndexPath) -> String? {
        return sourceList.count > indexPath.row ? sourceList[indexPath.row].name : nil
    }

    /// Get description of a source
    ///
    /// - Parameter indexPath: position of source on tableView
    /// - Returns: source's description
    func sourceDescription(at indexPath: IndexPath) -> String? {
        return sourceList.count > indexPath.row ? sourceList[indexPath.row].sourceDescription : nil
    }

    /// Get URL of a source
    ///
    /// - Parameter indexPath: position of source on tableView
    /// - Returns: source's URL
    func sourceUrl(at indexPath: IndexPath) -> String? {
        return sourceList.count > indexPath.row ? sourceList[indexPath.row].url : nil
    }
}
