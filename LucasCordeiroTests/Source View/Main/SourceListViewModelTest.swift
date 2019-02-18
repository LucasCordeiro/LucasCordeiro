//
//  SourceListViewModelTest.swift
//  LucasCordeiroTests
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import XCTest
@testable import LucasCordeiro

class SourceListViewModelTest: XCTestCase {

    var viewModelSut = SourceListViewModel()

    override func setUp() {
        ServerInfo.isStub = true
        viewModelSut = SourceListViewModel()
    }

    override func tearDown() {}

    func testListSource() {

        viewModelSut.listSource(completion: { (success, errorMessage) in
            XCTAssertTrue(success, "success should be true")
            XCTAssertNil(errorMessage, "errorMessage should be nil")
        })
    }

    func testNumberOfSection() {
        let guess = 1
        var valueSut = self.viewModelSut.numberOfSection()

        XCTAssertTrue(valueSut == guess, "Number of section must be not \(guess) but is \(valueSut)")

        viewModelSut.listSource { _, _  in
            valueSut = self.viewModelSut.numberOfSection()

            XCTAssertTrue(valueSut == guess, "Number of section must be \(guess) but is \(valueSut)")
        }
    }

    func testNumberOfRows() {
        let guess = 8
        let section = 0
        var valueSut = self.viewModelSut.numberOfRows(inSection: section)

        XCTAssertFalse(valueSut == guess, "Number Of Rows must be not \(guess) but is \(valueSut)")

        viewModelSut.listSource { _, _  in
            valueSut = self.viewModelSut.numberOfRows(inSection: section)

            XCTAssertTrue(valueSut == guess, "Number Of Rows must be \(guess) but is \(valueSut)")
        }
    }

    func testSourceName() {
        let guess = "ABC News"
        let indexPath = IndexPath(row: 0, section: 0)
        var valueSut = self.viewModelSut.sourceName(at: indexPath)

        XCTAssertFalse(valueSut == guess, "Source Name must be not \(guess) but is \(valueSut)")

        viewModelSut.listSource { _, _  in
            valueSut = self.viewModelSut.sourceName(at: indexPath)

            XCTAssertTrue(valueSut == guess, "Source Name must be \(guess) but is \(valueSut)")
        }
    }

    func testSourceDescription() {
        let guess = "Your trusted source for breaking news, " +
        "analysis, exclusive interviews, headlines, and videos at ABCNews.com."
        let indexPath = IndexPath(row: 0, section: 0)
        var valueSut = viewModelSut.sourceDescription(at: indexPath)

        XCTAssertFalse(valueSut == guess, "Source Description must be \(guess) but is \(valueSut)")

        viewModelSut.listSource { _, _  in
            valueSut = self.viewModelSut.sourceDescription(at: indexPath)

            XCTAssertTrue(valueSut == guess, "Source Description must be \(guess) but is \(valueSut)")
        }
    }

    func testSourceUrl() {
        let guess = "https://abcnews.go.com"
        let indexPath = IndexPath(row: 0, section: 0)
        var valueSut = self.viewModelSut.sourceUrl(at: indexPath)

        XCTAssertFalse(valueSut == guess, "Source URL must be not \(guess) but is \(valueSut)")

        viewModelSut.listSource { _, _  in
            valueSut = self.viewModelSut.sourceUrl(at: indexPath)

            XCTAssertTrue(valueSut == guess, "Source URL must be \(guess) but is \(valueSut)")
        }
    }

    func testSourceId() {
        let guess = "abc-news"
        let indexPath = IndexPath(row: 0, section: 0)
        var valueSut = self.viewModelSut.sourceId(at: indexPath) ?? ""

        XCTAssertFalse(valueSut == guess, "Source ID must be not \(guess) but is \(valueSut)")

        viewModelSut.listSource { _, _  in
            valueSut = self.viewModelSut.sourceId(at: indexPath) ?? ""

            XCTAssertTrue(valueSut == guess, "Source ID must be \(guess) but is \(valueSut)")
        }
    }
}
