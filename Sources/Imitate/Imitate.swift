//
//  Imitate.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

public class Imitate {

    // MARK: - Singleton

    public static let shared = Imitate()
    internal init() {}
   
    // MARK: - Mapping

    public typealias Matcher = (URLRequest) -> Bool
    public typealias Handler = (Environment) -> Void

    private var mapping: [(matcher: Matcher, handler: Handler, identifier: String?)] = []

    // MARK: -

    internal func find(_ request: URLRequest) -> Handler? {
        return mapping.first { $0.matcher(request) }?.handler
    }

    // MARK: - Matchers

    public func match(_ matcher: @escaping Matcher, with handler: @escaping Handler, identifier: String? = nil) {
        mapping.append((matcher: matcher, handler: handler, identifier: identifier))
    }

    // MARK: - Sugar

    public func get(_ string: String, with handler: @escaping Handler) {
        let matcher: (URLRequest) -> Bool = { $0.matches(string) && $0.httpMethod == "GET" }
        let identifier = "GET \(string)"

        match(matcher, with: handler, identifier: identifier)
    }

    public func post(_ string: String, with handler: @escaping Handler) {
        let matcher: (URLRequest) -> Bool = { $0.matches(string) && $0.httpMethod == "POST" }
        let identifier = "POST \(string)"

        match(matcher, with: handler, identifier: identifier)
    }

    public func unmatch(get string: String) {
        mapping.removeAll { $0.identifier == "GET \(string)" }
    }

    public func unmatch(post string: String) {
        mapping.removeAll { $0.identifier == "POST \(string)" }
    }

}
