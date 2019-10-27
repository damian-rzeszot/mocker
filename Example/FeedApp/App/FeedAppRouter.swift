//
//  FeedAppRouter.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation
import Imitate

class FeedAppRouter: Router {

    // MARK: - Singleton

    static let shared = FeedAppRouter()

    // MARK: -

    struct Post: Codable {
        let id: String
        let content: String
    }

    private var posts: [Post] = [
        Post(id: "000", content: "test 0"),
        Post(id: "111", content: "test 1"),
        Post(id: "222", content: "test 2")
    ]

    // MARK: -

    func start(with imitate: Imitate) {
        imitate.get("/api/feed", with: list)
        imitate.post("/api/post", with: create)
        imitate.get("/api/post/*", with: show)
    }

    func stop(with imitate: Imitate) {
        imitate.unmatch(get: "/api/feed")
        imitate.unmatch(post: "/api/post")
        imitate.unmatch(get: "/api/post/*")
    }

    // MARK: - GET /api/feed

    func list(env: Environment) {
        env.response.status = 200
        env.response.json(["entries": posts])
    }

    // MARK: - POST /api/post

    func create(env: Environment) {
        if let content = env.request.body(as: [String: String].self)?["content"] {
            posts.append(Post(content: content))

            env.response.status = 200
            env.response.json(["status": "ok"])
        } else {
            env.response.status = 400
            env.response.json(["status": "error"])
        }
    }

    // MARK: - GET /api/post/{id}

    private struct Response: Encodable {
        let post: Post
        let comments: [Post]

        static func sample(for id: String) -> Response {
            return Response(post: .init(id: id, content: "post \(id)"), comments: [
                .init(id: "\(id)-1", content: "comment \(id)-1"),
                .init(id: "\(id)-2", content: "comment \(id)-2"),
                .init(id: "\(id)-3", content: "comment \(id)-3"),
                .init(id: "\(id)-4", content: "comment \(id)-4")
            ])
        }
    }

    func show(env: Environment) {
        env.delay = 0.5

        if let id = env.request.url.absoluteString.split(separator: "/").last {
            if posts.contains(where: { $0.id == id }) {
                env.response.status = 200
                env.response.json(Response.sample(for: String(id)))
            } else {
                env.response.status = 404
            }
        } else {
            env.response.status = 400
        }
    }

}

extension FeedAppRouter.Post {

    init(content: String) {
        self.init(id: UUID().uuidString, content: content)
    }

}
