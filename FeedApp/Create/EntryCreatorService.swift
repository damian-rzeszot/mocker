//
//  EntryCreatorService.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

class EntryCreatorService {

    var session: URLSession! = .shared

    // MARK: -

    private struct Request: Encodable {
        let content: String
    }

    private struct Response: Decodable {
        enum Status: String, Decodable {
            case ok
            case error
        }
        let status: Status
    }

    // MARK: -

    func create(content: String, completion: @escaping (Bool) -> Void) {
        let body = Request(content: content)
        let encoder = JSONEncoder()

        var request = URLRequest(url: URL(string: "http://192.168.88.168:3000/api/post")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [ "Content-Type": "application/json" ]
        request.httpBody = try? encoder.encode(body)

        let task = session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()

            if let data = data, let payload = try? decoder.decode(Response.self, from: data) {
                completion(payload.status == .ok)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

}
