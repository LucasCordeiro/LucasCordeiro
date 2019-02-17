//
//  ListNewsViewController.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 15/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
import Lottie

class ListNewsViewController: UIViewController {

    //
    // MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingViewOutlet: LOTAnimationView!

    //
    // MARK: - Local Properties -
    private var viewModel: ListNewsViewModel?

    //
    // MARK: - Life Cycle Methods -
    static func storyboardInit(sourceId: String) -> ListNewsViewController {
        let storyboard = UIStoryboard.init(name: "NewsView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:
            ListNewsViewController.viewControllerDescription()) as? ListNewsViewController else {
            assertionFailure("Verify storyboard name and viewController identifier (on .stoyboard too)")
            return ListNewsViewController()
        }

        viewController.viewModel = ListNewsViewModel.init(sourceId: sourceId)

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        listNews(sourceId: nil)
    }

    //
    // MARK: - Configuration Methods -
    func configureViewModel(sourceId: String) {
        self.viewModel = ListNewsViewModel.init(sourceId: sourceId)
    }

    private func configureTableView() {
        let newsNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(newsNib, forCellReuseIdentifier: NewsTableViewCell.viewDescription())

        let loadingNib = UINib(nibName: "LoadingTableViewCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: LoadingTableViewCell.viewDescription())

        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }

    //
    // MARK: - List Methods -
    private func listNews(sourceId: String?) {

        tableView.setContentOffset(.zero, animated: false)
        loadingViewOutlet.showAndPlay(loopAnimation: true)
        viewModel?.listNews(sourceId: sourceId) { [weak self] (_, _) in
            guard let strongSelf = self  else {
                return
            }

            strongSelf.loadingViewOutlet.hideAndStop()
            strongSelf.tableView.reloadData()
        }
    }

    private func paginate() {
        viewModel?.paginateNews(completion: { [weak self] (_, _) in
            guard let strongSelf = self else {
                return
            }

            strongSelf.tableView.reloadData()
        })
    }
}

//
// MARK: - UIScrollViewDelegate Extension -
extension ListNewsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if currentOffset >= maximumOffset * 0.65 {
            paginate()
        }
    }
}

//
// MARK: - UITableViewDelegate Extension -
extension ListNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

//
// MARK: - UITableViewDataSource Extension -
extension ListNewsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSection() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if viewModel?.isLoadingSection(at: indexPath) ?? false {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                LoadingTableViewCell.viewDescription(), for: indexPath) as? LoadingTableViewCell else {
                    assertionFailure("No cell registred with " +
                        "\(LoadingTableViewCell.viewDescription()) identifier registred")

                    return UITableViewCell()
            }

            return cell
        } else {
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
}

//
// MARK: - EmptyDataSetSource Extension -
extension ListNewsViewController: EmptyDataSetSource {
}

//
// MARK: - EmptyDataSetDelegate Extension -
extension ListNewsViewController: EmptyDataSetDelegate {
}

extension ListNewsViewController: NewsContainerViewControllerDelegate {
    func didChangeSource(sourceId: String) {
        listNews(sourceId: sourceId)
    }
}
