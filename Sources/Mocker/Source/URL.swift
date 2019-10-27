//
//  URL.swift
//  Mocker
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

internal extension URL {

    func matches(_ string: String) -> Bool {
        if string.contains("*") {
            let pattern = string.replacingOccurrences(of: "*", with: "[^/]+")
            let regexp = try! NSRegularExpression(pattern: pattern, options: [])

            return regexp.matches(in: absoluteString, options: [], range: NSRange(location: 0, length: absoluteString.count)).count > 0
        } else if string.starts(with: "/") {
            return path == string
        }

        return absoluteString == string
    }

}
