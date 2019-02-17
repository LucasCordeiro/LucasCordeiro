//
//  SourceContainerViewController.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit

class SourceContainerViewController: UIViewController {

    @IBOutlet weak var leadingListConstraintOutlet: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            leadingListConstraintOutlet.constant = 0.0
        } else {
            leadingListConstraintOutlet.constant = CGFloat.greatestFiniteMagnitude
        }
    }
}
