//
//  Response.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

public class Response {

    // MARK: -

    public var status: Int?
    public var headers: Headers = Headers()

    public var body: Data?

    // MARK: -

    internal init() {

    }

    // MARK: -

    public func json<T: Encodable>(_ payload: T) {
        let encoder = JSONEncoder()

        body = try! encoder.encode(payload)
        headers["Content-Type"] = "application/json"
    }

    public subscript(_ key: String) -> String? {
        get {
            return headers[key]
        }
        set(value) {
            headers[key] = value
        }
    }

}
