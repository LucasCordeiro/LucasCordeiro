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
    private let viewModel = ListViewModel()
    
    //
    // MARK: - Life Cycle Methods -
    static func storyboardInit() -> ListViewController {
        let storyboard = UIStoryboard.init(name: "ListView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: ListViewController.viewControllerDescription()) as? ListViewController else {
            assertionFailure("Verify storyboard name and viewController identifier (on .stoyboard too)")
            
            return ListViewController()
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
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
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.viewDescription(), for: indexPath) as? NewsTableViewCell else {
            assertionFailure("No cell registred with \(NewsTableViewCell.viewDescription()) identifier registred")
            
            return UITableViewCell()
        }
        
        let newsTitle = viewModel.newsTitle(at: indexPath) ?? "Title Not Found"
        let newsDescription = viewModel.newsDescription(at: indexPath) ?? "Description Not Found"
        let newsThumbUrl = viewModel.newsThumbUrl(at: indexPath)
        
        cell.configureCell(newsTitle: newsTitle, newsDescription: newsDescription, newsImageURL: newsThumbUrl)
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
