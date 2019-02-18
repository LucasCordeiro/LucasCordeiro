//
//  ListViewModelTests.swift
//  LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 16/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
@testable import LucasCordeiro

class ListViewModelTests: XCTestCase {

    var viewModelSut = ListNewsViewModel(sourceId: "")

    override func setUp() {
        ServerInfo.isStub = true
        viewModelSut = ListNewsViewModel(sourceId: "")
    }

    override func tearDown() {}

    func testListNews() {

        viewModelSut.listNews(sourceId: "") { (success, errorMessage) in
            XCTAssertTrue(success, "success should be true")
            XCTAssertNil(errorMessage, "errorMessage should be nil")
        }
    }

    func testNumberOfSection() {
        let guess = 1
        var valueSut = self.viewModelSut.numberOfSection()

        XCTAssertTrue(valueSut == guess, "Number of section must be not \(guess) but is \(valueSut)")

        viewModelSut.listNews(sourceId: "") { _, _  in
            valueSut = self.viewModelSut.numberOfSection()

            XCTAssertTrue(valueSut == guess, "Number of section must be \(guess) but is \(valueSut)")
        }
    }

    func testNumberOfRowsNews() {
        let guess = 4
        let section = 0
        var valueSut = self.viewModelSut.numberOfRows(inSection: section)

        XCTAssertFalse(valueSut == guess, "Number Of Rows must be not \(guess) but is \(valueSut)")

        viewModelSut.listNews(sourceId: "") { _, _  in
            valueSut = self.viewModelSut.numberOfRows(inSection: section)

            XCTAssertTrue(valueSut == guess, "Number Of Rows must be \(guess) but is \(valueSut)")
        }
    }

    func testNumberOfRowsLoading() {
        let guess = 1
        let section = 1
        var valueSut = viewModelSut.numberOfRows(inSection: section)

        XCTAssertTrue(valueSut == guess, "Number Of Rows must be \(guess) but is \(valueSut)")

        viewModelSut.listNews(sourceId: "") { _, _  in }
        valueSut = viewModelSut.numberOfRows(inSection: section)

        XCTAssertTrue(valueSut == guess, "Number Of Rows must be \(guess) but is \(valueSut)")
    }

    func testNewsTitle() {
        let guess = "Senator to probe 'talk on ousting Trump'"
        let indexPath = IndexPath(row: 0, section: 0)
        var valueSut = self.viewModelSut.newsTitle(at: indexPath)

        XCTAssertFalse(valueSut == guess, "News Title must be not \(guess) but is \(valueSut)")

        viewModelSut.listNews(sourceId: "") { _, _  in
            valueSut = self.viewModelSut.newsTitle(at: indexPath)

            XCTAssertTrue(valueSut == guess, "News Title must be \(guess) but is \(valueSut)")
        }
    }

    func testNewsDescription() {
        let guess = "The pledge comes after an ex-acting FBI chief recalls discussions on removing the president."
        let indexPath = IndexPath(row: 0, section: 0)
        var valueSut = self.viewModelSut.newsDescription(at: indexPath)

        XCTAssertFalse(valueSut == guess, "News Title must be not \(guess) but is \(valueSut)")

        viewModelSut.listNews(sourceId: "") { _, _  in
            valueSut = self.viewModelSut.newsDescription(at: indexPath)

            XCTAssertTrue(valueSut == guess, "News Title must be \(guess) but is \(valueSut)")
        }
    }

    func testNewsDate() {
        let guess = "02/17/2019"
        let indexPath = IndexPath(row: 0, section: 0)
        var valueSut = self.viewModelSut.newsDate(at: indexPath)

        XCTAssertFalse(valueSut == guess, "News Title must be not \(guess) but is \(valueSut)")

        viewModelSut.listNews(sourceId: "") { _, _  in
            valueSut = self.viewModelSut.newsDate(at: indexPath)

            XCTAssertTrue(valueSut == guess, "News Title must be \(guess) but is \(valueSut)")
        }
    }

    func testNewsSourceName() {
        let guess = "BBC News"
        let indexPath = IndexPath(row: 0, section: 0)
        let valueSut = self.viewModelSut.newsSourceName(at: indexPath)

        XCTAssertFalse(valueSut == guess, "News Title must be not \(guess) but is \(valueSut)")

        viewModelSut.listNews(sourceId: "") { _, _  in
            let valueSut = self.viewModelSut.newsSourceName(at: indexPath)

            XCTAssertTrue(valueSut == guess, "News Title must be \(guess) but is \(valueSut)")
        }
    }

    func testIsLoadingSectionTrue() {
        let indexPath = IndexPath(row: 0, section: 1)

        viewModelSut.listNews(sourceId: "") { _, _  in
            let valueSut = self.viewModelSut.isLoadingSection(at: indexPath)

            XCTAssertTrue(valueSut, "isLoadingSection must be true")
        }
    }

    func testIsLoadingSectionFalse() {
        let indexPath = IndexPath(row: 0, section: 0)

        viewModelSut.listNews(sourceId: "") { _, _  in
            let valueSut = self.viewModelSut.isLoadingSection(at: indexPath)

            XCTAssertFalse(valueSut, "isLoadingSection must be true")
        }
    }

    func testPaginate() {
        viewModelSut.hasPagination = true

        viewModelSut.paginateNews(completion: { (success, errorMessage) in
            XCTAssertTrue(success, "success should be true")
            XCTAssertNil(errorMessage, "errorMessage should be nil")
        })
    }
}
