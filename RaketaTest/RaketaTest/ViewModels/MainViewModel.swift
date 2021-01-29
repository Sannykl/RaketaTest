//
//  MainViewModel.swift
//  RaketaTest
//
//  Created by mac on 28.01.2021.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func postsDidLoad()
}

class MainViewModel {
    var cellViewModels: [CellViewModelInterface] = []
    weak var delegate: MainViewModelDelegate?
    
    private let requestManager = RequestManager()
    private var after: String?
    private let limit = 10
    
    func loadData() {
        makeRequest(cellViewModels)
    }
    
    func reloadData() {
        after = nil
        makeRequest()
    }
    
    private func makeRequest(_ existingList: [CellViewModelInterface] = []) {
        var viewModels = existingList
        requestManager.loadTopItems(with: limit, after: after) { [weak self] (responseModel, error) in
            self?.after = responseModel?.data.after
            guard let postModels = responseModel?.data.children else { return }
            for model in postModels {
                let viewModel = CellViewModel(model: model)
                viewModels.append(viewModel)
            }
            self?.cellViewModels = viewModels
            self?.delegate?.postsDidLoad()
        }
    }
}
