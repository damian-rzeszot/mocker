//
//  Router.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

public protocol Router {
    func start(with imitate: Imitate)
    func stop(with imitate: Imitate)
}

extension Imitate {

    public func register(_ router: Router) {
        router.start(with: self)
    }

    public func unregister(_ router: Router) {
        router.stop(with: self)
    }

}
