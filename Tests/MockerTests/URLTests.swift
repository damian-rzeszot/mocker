//
//  URLTests.swift
//  MockerTests
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import Mocker

class URLTests: XCTestCase {

    func testFullPath() {
        let url = URL(string: "https://example.org/fullpath")

        XCTAssertNotNil(url)
        XCTAssertEqual(url?.matches("https://example.org/fullpath"), true)
    }

}
