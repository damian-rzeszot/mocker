//
//  MockerTests.swift
//  MockerTests
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import Mocker

class MockerTests: XCTestCase {

    func testGetRequest() {
        let mocker = Mocker()
        mocker.get("/test") { _ in }

        XCTAssertNotNil(mocker.find(.get("https://example.org/test")))
    }

    func testPostRequest() {
        let mocker = Mocker()
        mocker.post("/test") { _ in }

        XCTAssertNotNil(mocker.find(.post("https://example.org/test")))
    }

    func testGetRequestUnmatching() {
        let mocker = Mocker()
        mocker.get("/test") { _ in }

        mocker.unmatch(get: "/test")

        XCTAssertNil(mocker.find(.get("https://example.org/test")))
    }

    func testPostRequestUnmatching() {
        let mocker = Mocker()
        mocker.post("/test") { _ in }

        mocker.unmatch(post: "/test")

        XCTAssertNil(mocker.find(.post("https://example.org/test")))
    }

    func testGetMatching() {
        var called = false
        let request = URLRequest.get("https://example.org/test")

        let mocker = Mocker()
        mocker.get("/test") { env in
            called = true
        }

        let env = Environment(request: request)
        let handler = mocker.find(request)

        handler?(env)
        XCTAssertTrue(called)
    }

    func testStrictMatching() {
        let mocker = Mocker()
        mocker.get("https://example.org/v1") { _ in }

        XCTAssertNotNil(mocker.find(.get("https://example.org/v1")))
    }

    func testPatternPartialMatching() {
        let mocker = Mocker()
        mocker.get("/posts/*/details") { _ in }

        XCTAssertNotNil(mocker.find(.get("https://example.org/posts/12345/details")))
    }

    func testPatternFullMatching() {
        let mocker = Mocker()
        mocker.get("https://example.org/posts/*/details") { _ in }

        XCTAssertNotNil(mocker.find(.get("https://example.org/posts/12345/details")))
    }

}

private extension URLRequest {

    static func get(_ url: String) -> URLRequest {
        return URLRequest(url: URL(string: url)!)
    }

    static func post(_ url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        return request
    }

}
