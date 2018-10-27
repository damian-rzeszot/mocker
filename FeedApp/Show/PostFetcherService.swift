//
//  PostFetcherService.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

struct PostPayload: Decodable {
    struct Comment: Decodable {
        let id: String
        let content: String
    }

    let post: FeedPayload.Entry
    let comments: [Comment]
}

class PostFetcherService {

    // MARK: -

    var session: URLSession! = .shared

    // MARK: -

    func fetch(id: String, completion: @escaping (PostPayload?) -> Void) {
        let task = session.dataTask(with:URL.post(with: id)) { data, response, error in
            let decoder = JSONDecoder()

            if let data = data, let payload = try? decoder.decode(PostPayload.self, from: data) {
                completion(payload)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }

}

extension URL {

    static func post(with id: String) -> URL {
        return URL(string: "http://192.168.88.168:3000/api/post/\(id)")!
    }

}
