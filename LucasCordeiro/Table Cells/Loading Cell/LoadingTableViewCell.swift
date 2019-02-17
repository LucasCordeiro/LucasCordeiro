//
//  LoadingTableViewCell.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import Lottie

class LoadingTableViewCell: UITableViewCell {

    //
    // MARK: - Outlets -
    @IBOutlet weak var loadingViewOutlet: LOTAnimationView!

    //
    // MARK: - Life Cycle Methods -
    override func awakeFromNib() {
        super.awakeFromNib()

        loadingViewOutlet.loopAnimation = true
        loadingViewOutlet.play()
    }
}
