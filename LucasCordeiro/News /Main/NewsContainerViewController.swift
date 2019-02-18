//
//  SourceContainerViewController.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit

protocol NewsContainerViewControllerDelegate: class {
    func didChangeSource(sourceId: String)
}

class NewsContainerViewController: UIViewController {

    //
    // MARK: - Outlets -
    @IBOutlet weak var leadingListConstraintOutlet: NSLayoutConstraint!

    //
    // MARK: Local Properties
    private var sourceId: String?

    private var sourceViewController: SourceListViewController?

    weak private var delegate: NewsContainerViewControllerDelegate?

    //
    // MARK: - Life Cycle Methods -
    static func storyboardInit(sourceId: String) -> NewsContainerViewController {
        let storyboard = UIStoryboard.init(name: "NewsView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:
            NewsContainerViewController.viewControllerDescription()) as? NewsContainerViewController else {
                assertionFailure("Verify storyboard name and viewController identifier on .stoyboard too)")
                return NewsContainerViewController()
        }

        viewController.sourceId = sourceId

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        if UIDevice.current.orientation.isPortrait {
            leadingListConstraintOutlet.constant = 0.0
        } else {
            leadingListConstraintOutlet.constant = CGFloat.greatestFiniteMagnitude
        }
    }

    //
    // MARK: - Transition Methods -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ListNewsViewController {
            if let sourceId = sourceId {
                viewController.configureViewModel(sourceId: sourceId)
            }

            self.delegate = viewController
            if let sourceViewController = self.sourceViewController {
                sourceViewController.delegate = viewController
            }
        }

        if let viewController = segue.destination as? SourceListViewController {

            if let delegate = self.delegate {
                viewController.delegate = delegate
            } else {
                sourceViewController = viewController
            }
        }
    }
}
