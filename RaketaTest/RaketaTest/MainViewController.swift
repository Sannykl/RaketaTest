//
//  MainViewController.swift
//  RaketaTest
//
//  Created by Sasha Klovak on 28.01.2021.
//

import UIKit

class MainViewController: UIViewController {

    private let viewModel = MainViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadData()
    }
}

extension MainViewController: MainViewModelDelegate {
    
    func postsDidLoad() {
        
    }
}

//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.cellViewModels.count
//    }
//
//
//}
