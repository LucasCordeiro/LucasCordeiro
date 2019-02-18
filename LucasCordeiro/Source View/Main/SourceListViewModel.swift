//
//  SourceListViewModel.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import OHHTTPStubs

class SourceListViewModel: NSObject {

    //
    // MARK: - Local Properties -
    private var sourceList: [NewsSource] = []

    private var country = "us"

    //
    // MARK: - Life Cycle Methods -
    override init() {
        super.init()

        initializeStubs()
    }

    //
    // MARK: - Sources Method -
    /// Get list of news
    ///
    /// - Parameters:
    ///   - completion: returns 'success'property and 'errorMessage' if appliable
    func listSource(completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void) {
        APIClient.listSources(country: country) { [weak self] (result) in
            guard let strongSelf = self else {
                completion(false, "Reference error")
                return
            }
            var success = false
            var errorMessage: String?

            if let validResult = try? result.unwrap() {
                if let sources = validResult.sources {
                    strongSelf.sourceList.append(contentsOf: sources)
                    success = true
                }
            } else {
                errorMessage = "Service error. Try to verify listSources methods."
            }

            completion(success, errorMessage)
        }
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
    func sourceName(at indexPath: IndexPath) -> String {
        return sourceList.count > indexPath.row
            ? sourceList[indexPath.row].name ?? "Title Not Found"
            : "Title Not Found"
    }

    /// Get description of a source
    ///
    /// - Parameter indexPath: position of source on tableView
    /// - Returns: source's description
    func sourceDescription(at indexPath: IndexPath) -> String {
        return sourceList.count > indexPath.row
            ? sourceList[indexPath.row].sourceDescription ?? "Description Not Found"
            : "Description Not Found"
    }

    /// Get URL of a source
    ///
    /// - Parameter indexPath: position of source on tableView
    /// - Returns: source's URL
    func sourceUrl(at indexPath: IndexPath) -> String {
        return sourceList.count > indexPath.row
            ? sourceList[indexPath.row].url ?? "URL Not Found"
            : "URL Not Found"
    }

    /// Get ID of a source
    ///
    /// - Parameter indexPath: position of source on tableView
    /// - Returns: source's ID
    func sourceId(at indexPath: IndexPath) -> String? {
        return sourceList.count > indexPath.row ? sourceList[indexPath.row].sourceID : nil
    }
}

extension SourceListViewModel: StubViewModelDelegate {
    func initializeStubs() {

        if ServerInfo.isStub {
            let listSourcesPath = "listSources"
            let listSourcesJSONPath = "newsSource.json"

            stub(condition: pathEndsWith(listSourcesPath)) { _ in
                let stubPath = OHPathForFile(listSourcesJSONPath, type(of: self))
                return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
            }
        }
    }
}
