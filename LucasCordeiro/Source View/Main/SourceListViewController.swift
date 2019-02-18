//
//  SourceListViewController.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 17/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
import Lottie

class SourceListViewController: UIViewController {

    //
    // MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingViewOutlet: LOTAnimationView!

    //
    // MARK: - Local Properties -
    private let viewModel = SourceListViewModel()
    weak var delegate: NewsContainerViewControllerDelegate?

    //
    // MARK: - Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingViewOutlet.showAndPlay(loopAnimation: true)
        viewModel.listSource { [weak self] (_, _) in
            guard let strongSelf = self else {
                return
            }

            strongSelf.loadingViewOutlet.hideAndStop()
            strongSelf.tableView.reloadData()
        }

        configureTableView()
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
extension SourceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sourceId = viewModel.sourceId(at: indexPath) {
            if let delegate = delegate {
                delegate.didChangeSource(sourceId: sourceId)
            } else {
                let viewController = NewsContainerViewController.storyboardInit(sourceId: sourceId)

                self.navigationController?.pushViewController(viewController, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        } else {

        }
    }
}

//
// MARK: - UITableViewDataSource Extension -
extension SourceListViewController: UITableViewDataSource {
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

        let sourceName = viewModel.sourceName(at: indexPath)
        let sourceDescription = viewModel.sourceDescription(at: indexPath)
        let sourceUrl = viewModel.sourceUrl(at: indexPath)

        cell.configureCell(sourceName: sourceName,
                           sourceDescription: sourceDescription,
                           sourceUrl: sourceUrl)

        return cell
    }
}

//
// MARK: - EmptyDataSetSource Extension -
extension SourceListViewController: EmptyDataSetSource {
}

//
// MARK: - EmptyDataSetDelegate Extension -
extension SourceListViewController: EmptyDataSetDelegate {
}
