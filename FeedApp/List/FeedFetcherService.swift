//
//  FeedFetcherService.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation


struct FeedPayload: Decodable {

    struct Entry: Decodable {
        let id: String
        let content: String
    }

    let entries: [Entry]
}


class FeedFetcherService {

    var session: URLSession! = .shared

    func fetch(completion: @escaping (FeedPayload?) -> Void) {
        let url = URL(string: "http://192.168.88.168:3000/api/feed")!

        let task = session.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()

            if let data = data, let payload = try? decoder.decode(FeedPayload.self, from: data) {
                completion(payload)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }
}
