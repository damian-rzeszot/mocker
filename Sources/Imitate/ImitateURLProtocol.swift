//
//  ImitateURLProtocol.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

public class ImitateURLProtocol: URLProtocol {

    // MARK: -

    internal static var imitate: Imitate! = .shared

    internal var imitate: Imitate {
        return ImitateURLProtocol.imitate
    }

    // MARK: -

    override public class func canInit(with request: URLRequest) -> Bool {
        return imitate.find(request) != nil
    }

    override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    // MARK: -

    override public func startLoading() {
        guard let handler = imitate.find(request) else { return }

        let env = Environment(request: request)

        handler(env)

        after(env.delay) {
            self.complete(env)
        }
    }

    override public func stopLoading() {

    }

    // MARK: -

    private func after(_ time: TimeInterval? = nil, completion: @escaping () -> Void) {
        if let time = time {
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(Int(time * 1000))) {
                completion()
            }
        } else {
            completion()
        }
    }

    private func complete(_ env: Environment) {
        let status = env.response.status ?? 200
        let url = request.url!
        let headers = env.response.headers

        let receive = HTTPURLResponse(url: url, statusCode: status, httpVersion: nil, headerFields: headers.dictionary)!

        client?.urlProtocol(self, didReceive: receive, cacheStoragePolicy: .notAllowed)

        if let data = env.response.body {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

}
