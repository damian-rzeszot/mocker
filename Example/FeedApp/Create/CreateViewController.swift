//
//  CreateViewController.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    // MARK: -

    var service: EntryCreatorService! = EntryCreatorService()

    // MARK: - Outlets

    @IBOutlet private var backBarItem: UIBarButtonItem!
    @IBOutlet private var saveBarItem: UIBarButtonItem!
    @IBOutlet private var textView: UITextView!

    // MARK: - Actions

    @IBAction private func backAction() {
        dismiss(animated: true)
    }

    @IBAction private func sendAction() {
        let text = textView.text ?? ""

        set(loading: true)
        service.create(content: text) { [weak self] success in
            DispatchQueue.main.async {
                self?.set(loading: false)
                self?.dismiss(animated: true)
            }
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        backBarItem.accessibilityIdentifier = "add-back-button"
        saveBarItem.accessibilityIdentifier = "add-send-button"
        textView.accessibilityIdentifier = "add-textview"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }

    // MARK: - Helpers

    private func set(loading: Bool) {
        navigationItem.leftBarButtonItem?.isEnabled = !loading

        if loading {
            let activity = UIActivityIndicatorView()
            activity.startAnimating()
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
        } else {
            navigationItem.rightBarButtonItem = saveBarItem
        }
    }
}
