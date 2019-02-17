//
//  SourceViewController.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class SourceViewController: UIViewController {

    //
    // MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView!

    //
    // MARK: - Local Properties -
    private let viewModel = SourceViewModel()

    //
    // MARK: - Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //
    // MARK: - Configuration Methods -
    private func configureTableView() {
        let nib = UINib(nibName: "SourceTableViewCell", bundle: nil)

        tableView.register(nib, forCellReuseIdentifier: SourceTableViewCell.viewDescription())

        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}

//
// MARK: - UITableViewDelegate Extension -
extension SourceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

//
// MARK: - UITableViewDataSource Extension -
extension SourceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            SourceTableViewCell.viewDescription(), for: indexPath) as? SourceTableViewCell else {
                assertionFailure("No cell registred with \(SourceTableViewCell.viewDescription()) identifier registred")

                return UITableViewCell()
        }

        let sourceName = viewModel.sourceName(at: indexPath) ?? "Name Not Found"
        let sourceDescription = viewModel.sourceDescription(at: indexPath) ?? "Description Not Found"
        let sourceUrl = viewModel.sourceUrl(at: indexPath) ?? "URL Not Found"

        cell.configureCell(sourceName: sourceName,
                           sourceDescription: sourceDescription,
                           sourceUrl: sourceUrl)

        return cell
    }
}

//
// MARK: - EmptyDataSetSource Extension -
extension SourceViewController: EmptyDataSetSource {
}

//
// MARK: - EmptyDataSetDelegate Extension -
extension SourceViewController: EmptyDataSetDelegate {
}
