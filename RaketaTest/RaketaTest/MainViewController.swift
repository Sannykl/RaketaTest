//
//  MainViewController.swift
//  RaketaTest
//
//  Created by Sasha Klovak on 28.01.2021.
//

import UIKit

class MainViewController: UIViewController {

    private let viewModel = MainViewModel()
    
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        viewModel.delegate = self
        viewModel.loadData()
    }
    
    @objc private func refreshAction() {
        viewModel.reloadData()
    }
}

extension MainViewController: MainViewModelDelegate {
    
    func postsDidLoad() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    private func prepareTableView() {
        tableView.register(UINib(nibName: String(describing: PostCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PostCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self)) as! PostCell
        cell.fill(with: viewModel.cellViewModels[indexPath.row])
        viewModel.didShowPost(at: indexPath)
        return cell
    }
}
