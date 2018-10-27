//
//  RequestTests.swift
//  MockerTests
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import Mocker

class RequestTests: XCTestCase {

    // MARK: -

    func testURLInitialization() {
        let input = URLRequest(url: URL(string: "https://example.org/12345")!)

        let request = Request(request: input)

        XCTAssertEqual(request.url.absoluteString, input.url?.absoluteString)
    }

    func testBodyNilInitialization() {
        let input = URLRequest(url: URL(string: "https://example.org/12345")!)

        let request = Request(request: input)

        XCTAssertNil(request.body)
    }

    func testBodyDataInitialization() {
        var input = URLRequest(url: URL(string: "https://example.org/12345")!)
        input.httpBody = "hello world".data(using: .utf8)

        let request = Request(request: input)

        XCTAssertNotNil(request.body)
        XCTAssertEqual(String(data: request.body!, encoding: .utf8), "hello world")
    }

    func testBodyStreamInitialization() {
        var input = URLRequest(url: URL(string: "https://example.org/12345")!)
        input.httpBodyStream = InputStream(data: "hello world".data(using: .utf8)!)

        let request = Request(request: input)

        XCTAssertNotNil(request.body)
        XCTAssertEqual(String(data: request.body!, encoding: .utf8), "hello world")
    }

    // MARK: -

    private struct GoodTest: Decodable {
        struct Entry: Decodable {
            let content: String
        }
        let entries: [Entry]
    }

    private struct BadTest: Decodable {
        let number: Int
    }

    func testBodyGoodDeserialization() {
        var input = URLRequest(url: URL(string: "https://example.org/12345")!)
        input.httpBody = """
            {
                "entries": [
                    { "content": "hello" },
                    { "content": "world" }
                ]
            }
            """.data(using: .utf8)

        let request = Request(request: input)

        let body = request.body(as: GoodTest.self)

        XCTAssertNotNil(body)
        XCTAssertEqual(body?.entries.count, 2)
        XCTAssertEqual(body?.entries[0].content, "hello")
        XCTAssertEqual(body?.entries[1].content, "world")
    }

    func testBodyBadDeserialization() {
        var input = URLRequest(url: URL(string: "https://example.org/12345")!)
        input.httpBody = """
            {
                "entries": [
                    { "content": "hello" },
                    { "content": "world" }
                ]
            }
            """.data(using: .utf8)

        let request = Request(request: input)

        let body = request.body(as: BadTest.self)

        XCTAssertNil(body)
    }

    func testBodyBadNilDeserialization() {
        let input = URLRequest(url: URL(string: "https://example.org/12345")!)

        let request = Request(request: input)
        let body = request.body(as: BadTest.self)

        XCTAssertNil(body)
    }

}
