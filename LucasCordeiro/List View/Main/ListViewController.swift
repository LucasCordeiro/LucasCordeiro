//
//  ListViewController.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 15/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class ListViewController: UIViewController {

    //
    // MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView!

    //
    // MARK: - Local Properties -
    private var viewModel: ListViewModel?

    //
    // MARK: - Life Cycle Methods -
    static func storyboardInit(sourceId: String) -> ListViewController {
        let storyboard = UIStoryboard.init(name: "ListView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:
            ListViewController.viewControllerDescription()) as? ListViewController else {
            assertionFailure("Verify storyboard name and viewController identifier (on .stoyboard too)")
            return ListViewController()
        }

        viewController.viewModel = ListViewModel.init(sourceId: sourceId)

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.listNews { [weak self] (_, _) in
            guard let strongSelf = self  else {
                return
            }

            strongSelf.tableView.reloadData()
        }
    }

    //
    // MARK: - Configuration Methods -
    private func configureTableView() {
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)

        tableView.register(nib, forCellReuseIdentifier: NewsTableViewCell.viewDescription())

        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}

//
// MARK: - UITableViewDelegate Extension -
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

//
// MARK: - UITableViewDataSource Extension -
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSection() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            NewsTableViewCell.viewDescription(), for: indexPath) as? NewsTableViewCell else {
            assertionFailure("No cell registred with \(NewsTableViewCell.viewDescription()) identifier registred")

            return UITableViewCell()
        }

        if let viewModel = viewModel {
            let newsTitle = viewModel.newsTitle(at: indexPath)
            let newsDescription = viewModel.newsDescription(at: indexPath)
            let newsDate = viewModel.newsDate(at: indexPath)
            let newsSourceName = viewModel.newsSourceName(at: indexPath)
            let newsThumbUrl = viewModel.newsThumbUrl(at: indexPath)

            cell.configureCell(newsTitle: newsTitle,
                               newsDescription: newsDescription,
                               newsDate: newsDate,
                               newsSourceName: newsSourceName,
                               newsImageURL: newsThumbUrl)
        }

        return cell
    }
}

//
// MARK: - EmptyDataSetSource Extension -
extension ListViewController: EmptyDataSetSource {
}

//
// MARK: - EmptyDataSetDelegate Extension -
extension ListViewController: EmptyDataSetDelegate {
}
