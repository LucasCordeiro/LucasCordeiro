//
//  SourceTableViewCell.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    //
    // MARK: - Outlets -
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var urlLabelOutlet: UILabel!
    @IBOutlet weak var descriptionLabelOutlet: UILabel!

    //
    // MARK: - Life Cycle Methods -
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //
    // MARK: - Configure Methods -
    func configureCell(sourceName: String,
                       sourceDescription: String,
                       sourceUrl: String) {

        nameLabelOutlet.text = sourceName
        urlLabelOutlet.text = sourceUrl
        descriptionLabelOutlet.text = sourceDescription
    }
}
