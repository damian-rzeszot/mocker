//
//  AppDelegate.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit

import Mocker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: -

    func application(_ app: UIApplication, didFinishLaunchingWithOptions launch: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
            let options = CommandLine.arguments

            if options.contains("--mocked-network") {
                NSLog("debug | using mocked network")

                URLProtocol.registerClass(MockURLProtocol.self)
                Mocker.shared.register(FeedAppRouter.shared)
            }
        #endif

        return true
    }

}
