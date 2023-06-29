//
//  InstantSystemTestTests.swift
//  InstantSystemTestTests
//
//  Created by Guillaume on 26/06/2023.
//

import XCTest
@testable import InstantSystemTest

final class InstantSystemTestTests: XCTestCase {
    
    func testGetNewsShouldPostFailedCallbackIfInvalidUrl() {
        // Given
        let url = "Pas bonne url"
        var error: NetworkErrors = .noError
        let errorAwaited: NetworkErrors = .invalidURL
        let newsService = NewsServices(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        XCTAssertNotEqual(error, errorAwaited)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        newsService.getNews(stringAdress: url) { result in
            // Then
            switch result {
                case.failure(let errorReceived):
                    error = errorReceived
                case.success( _):
                    XCTFail()
            }
            XCTAssertEqual(error, errorAwaited)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNewsShouldPostFailedCallbackIfError() {
        // Given
        var error: NetworkErrors = .noError
        let errorAwaited: NetworkErrors = .errorGenerated
        let newsService = NewsServices(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        XCTAssertNotEqual(error, errorAwaited)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        newsService.getNews(stringAdress: "https://www.bonneAdresse.com") { result in
            // Then
            switch result {
                case.failure(let errorReceived):
                    error = errorReceived
                case.success( _):
                    XCTFail()
            }
            XCTAssertEqual(error, errorAwaited)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNewsShouldPostFailedCallbackIfNoData() {
        // Given
        var error: NetworkErrors = .noError
        let errorAwaited: NetworkErrors = .noData
        let newsService = NewsServices(session: URLSessionFake(data: nil, response: FakeResponseData.responseOk, error: nil))
        XCTAssertNotEqual(error, errorAwaited)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        newsService.getNews(stringAdress: "https://www.bonneAdresse.com") { result in
            // Then
            switch result {
                case.failure(let errorReceived):
                    error = errorReceived
                case.success( _):
                    XCTFail()
            }
            XCTAssertEqual(error, errorAwaited)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNewsShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        var error: NetworkErrors = .noError
        let errorAwaited: NetworkErrors = .invalidStatusCode
        let newsService = NewsServices(session: URLSessionFake(data: FakeResponseData.NewsCorrectData, response: FakeResponseData.responseKo, error: nil))
        XCTAssertNotEqual(error, errorAwaited)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        newsService.getNews(stringAdress: "https://www.bonneAdresse.com") { result in
            // Then
            switch result {
                case.failure(let errorReceived):
                    error = errorReceived
                case.success( _):
                    XCTFail()
            }
            XCTAssertEqual(error, errorAwaited)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNewsShouldPostFailedCallbackIfIncorrectData() {
        // Given
        var error: NetworkErrors = .noError
        let errorAwaited: NetworkErrors = .decodingError
        let newsService = NewsServices(session: URLSessionFake(data: FakeResponseData.NewsIncorrectData, response: FakeResponseData.responseOk, error: nil))
        XCTAssertNotEqual(error, errorAwaited)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        newsService.getNews(stringAdress: "https://www.bonneAdresse.com") { result in
            // Then
            switch result {
                case.failure(let errorReceived):
                    error = errorReceived
                case.success( _):
                    XCTFail()
            }
            XCTAssertEqual(error, errorAwaited)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetNewsShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        var author = ""
        let authorAwaited = "Andrew Tarantola"
        let newsService = NewsServices(session: URLSessionFake(data: FakeResponseData.NewsCorrectData, response: FakeResponseData.responseOk, error: nil))
        XCTAssertNotEqual(authorAwaited, author)
        // When
        print("01")
        let expectation = XCTestExpectation(description: "Wait for queue change")
        newsService.getNews(stringAdress: "https://www.bonneAdresse.com") { result in
            // Then
            switch result {
                case.failure( _):
                    XCTFail()
                case.success(let data):
                    author = data.articles[0].author ?? "No author"
            }
            XCTAssertEqual(authorAwaited, author)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
