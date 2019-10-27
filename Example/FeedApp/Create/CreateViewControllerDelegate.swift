//
//  CreateViewControllerDelegate.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit

protocol CreateViewControllerDelegate: class {
    func createViewControllerDidCancel(_ createViewController: CreateViewController)
    func createViewControllerDidFinish(_ createViewController: CreateViewController)
}


extension CreateViewControllerDelegate where Self: UIViewController {
    func createViewControllerDidCancel(_ createViewController: CreateViewController) {
        dismiss(animated: true)
    }

    func createViewControllerDidFinish(_ createViewController: CreateViewController) {
        dismiss(animated: true)
    }
}
