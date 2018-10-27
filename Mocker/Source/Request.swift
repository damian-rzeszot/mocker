//
//  Request.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

public class Request {

    // MARK: -

    public let url: URL
    public let body: Data?

    // MARK: -

    internal init(request: URLRequest) {
        if let body = request.httpBody {
            self.body = body
        } else if let stream = request.httpBodyStream {
            self.body = Data(reading: stream)
        } else {
            self.body = nil
        }

        self.url = request.url!
    }

    // MARK: -

    public func body<T: Decodable>(as klass: T.Type) -> T? {
        guard let body = body else { return nil }

        let decoder = JSONDecoder()
        return try? decoder.decode(klass, from: body)
    }

}
