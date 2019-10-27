//
//  Environment.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

public class Environment {

    // MARK: -

    public let request: Request
    public let response: Response

    // MARK: -

    public var delay: TimeInterval?

    // MARK: -

    public init(request: URLRequest) {
        self.request = Request(request: request)
        self.response = Response()
    }

    // MARK: -

    public func load(from file: String, in bundle: Bundle = .main) {
        guard let url = bundle.url(forRespource: file) else { return }

        let data = try! String(contentsOf: url)
        let chunks = data.components(separatedBy: "\n---\n")

        for header in chunks[0].split(separator: "\n") {
            let parts = header.components(separatedBy: ": ")
            let key = parts[0]
            let value = parts[1]

            switch key {
            case "status":
                response.status = Int(value)
            case "delay":
                delay = TimeInterval(value)
            default:
                response[key] = value
            }
        }

        response.body = chunks[1].data(using: .utf8)
    }

}

private extension Bundle {

    func url(forRespource name: String) -> URL? {
        let parts = name.split(separator: ".")
        return url(forResource: String(parts[0]), withExtension: String(parts[1]))
    }

}
