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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        activityIndicator.isHidden = viewModel.hideActivityIndicator
        prepareTableView()
    }
    
    @objc private func refreshAction() {
        viewModel.reloadData()
    }
}

extension MainViewController: MainViewModelDelegate {
    
    func postsDidLoad() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        activityIndicator.isHidden = true
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
        
        cell.onImageTap = { [unowned self] url in
            let imageVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: ImageViewController.self)) as! ImageViewController
            imageVC.imageURL = url
            self.present(imageVC, animated: true, completion: nil)
        }
        
        viewModel.didShowPost(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
}
