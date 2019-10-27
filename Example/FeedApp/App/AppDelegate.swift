//
//  AppDelegate.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit
import Imitate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: -

    func application(_ app: UIApplication, didFinishLaunchingWithOptions launch: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        URLProtocol.registerClass(ImitateURLProtocol.self)
        Imitate.shared.register(FeedAppRouter.shared)

        return true
    }

}
