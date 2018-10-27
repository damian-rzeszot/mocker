//
//  ShowViewController.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    // MARK: -

    var post: FeedPayload.Entry!

    // MARK: -

    let service = PostFetcherService()

    // MARK: -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        service.fetch(id: post.id) { payload in
            print("xxx \(String(describing: payload))")
        }
    }

}
