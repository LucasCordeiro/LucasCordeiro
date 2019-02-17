//
//  NewsTableViewCell.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 15/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import SDWebImage
import Lottie

class NewsTableViewCell: UITableViewCell {

    //
    // MARK: - Outlets -
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var descriptionLabelOutlet: UILabel!
    @IBOutlet weak var imageLoadingView: LOTAnimationView!
    @IBOutlet weak var sourceLabelOutlet: UILabel!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    //
    // MARK: - Life Cycle Methods -
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //
    // MARK: - Configure Methods -
    func configureCell(newsTitle: String,
                       newsDescription: String,
                       newsDate: String,
                       newsSourceName: String,
                       newsImageURL: URL?) {

        titleLabelOutlet.text = newsTitle
        descriptionLabelOutlet.text = newsDescription
        sourceLabelOutlet.text = newsSourceName
        dateLabelOutlet.text = newsDate

        imageLoadingView.isHidden = false
        imageLoadingView.loopAnimation = true
        imageLoadingView.play()

        imageViewOutlet.sd_setImage(with: newsImageURL) { [weak self] (_, error, _, _) in
            guard let strongSelf = self else {
                return
            }

            strongSelf.imageLoadingView.isHidden = true
            strongSelf.imageLoadingView.stop()

            if error != nil {
                strongSelf.imageViewOutlet.image = #imageLiteral(resourceName: "brokenImage")
            }
        }
    }
}
