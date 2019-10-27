//
//  FeedViewController.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: -

    var payload: FeedPayload?
    var service: FeedFetcherService! = FeedFetcherService()

    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var refreshBarItem: UIBarButtonItem!
    @IBOutlet private var addBarItem: UIBarButtonItem!

    // MARK: - Actions

    @IBAction private func refreshAction() {
        set(loading: true)

        service.fetch { payload in
            DispatchQueue.main.async { [weak self] in
                self?.payload = payload
                self?.tableView.reloadData()
                self?.set(loading: false)
            }
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshBarItem.accessibilityIdentifier = "feed-refresh-button"
        addBarItem.accessibilityIdentifier = "feed-add-button"
        tableView.accessibilityIdentifier = "feed-tableview"

        set(loading: false)
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        refreshAction()
    }

    // MARK: - Helpers

    func set(loading: Bool) {
        if loading {
            let activity = UIActivityIndicatorView()
            activity.startAnimating()
            let loadingBarItem = UIBarButtonItem(customView: activity)

            navigationItem.leftBarButtonItem = loadingBarItem
        } else {
            navigationItem.leftBarButtonItem = refreshBarItem
        }
    }

    // MARK: -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowViewController {
            guard let cell = sender as? UITableViewCell,
                let path = tableView.indexPath(for: cell) else { return }

            vc.post = payload?.entries[path.row]
        } else if let nav = segue.destination as? UINavigationController, let vc = nav.topViewController as? CreateViewController {
            vc.delegate = self
        }
    }

}

extension FeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payload?.entries.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if let cell = cell as? FeedEntryCell, let entry = payload?.entries[indexPath.row] {
            cell.configure(content: entry.content)
            cell.backgroundColor = UIColor.palette[indexPath.row % UIColor.palette.count]
        }

        return cell
    }
}

extension FeedViewController: CreateViewControllerDelegate {
    func createViewControllerDidFinish(_ createViewController: CreateViewController) {
        refreshAction()
        dismiss(animated: true)
    }
}

extension UIColor {
    static var palette: [UIColor] = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)].shuffled()
}
