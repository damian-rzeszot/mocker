//
//  RouterTests.swift
//  MockerTests
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import Mocker

class RouterTests: XCTestCase {

    func testStart() {
        let mocker = MockMocker()
        let router = ChildRouter()

        mocker.register(router)

        XCTAssertEqual(mocker.actions.count, 1)
        XCTAssertEqual(mocker.actions.first, "+ GET /example")
    }

    func testStop() {
        let mocker = MockMocker()
        let router = ChildRouter()

        mocker.unregister(router)

        XCTAssertEqual(mocker.actions.count, 1)
        XCTAssertEqual(mocker.actions.first, "- GET /example")
    }

}

class ChildRouter: Router {

    func start(with mocker: Mocker) {
        mocker.get("/example") { env in
            // ...
        }
    }

    func stop(with mocker: Mocker) {
        mocker.unmatch(get: "/example")
    }

}
