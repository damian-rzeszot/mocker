//
//  MockMocker.swift
//  MockerTests
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation
@testable import Mocker

class MockMocker: Mocker {

    // MARK: -

    var handler: ((Environment) -> Void)?

    override func find(_ request: URLRequest) -> Mocker.Handler? {
        return handler
    }

    // MARK: -

    private(set) var actions: [String] = []

    func reset() {
        actions = []
    }

    // MARK: -

    override func get(_ string: String, with handler: @escaping Mocker.Handler) {
        actions.append("+ GET \(string)")
    }

    override func unmatch(get string: String) {
        actions.append("- GET \(string)")
    }

}
