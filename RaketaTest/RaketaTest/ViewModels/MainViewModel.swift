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
    private var loadingInProgress = false
    
    init() {
        if CoreDataManager.hasData() {
            prepareCoreDataViewModels()
        } else {
            loadData()
        }
    }
    
    func loadData() {
        makeRequest(cellViewModels)
    }
    
    func reloadData() {
        after = nil
        makeRequest()
    }
    
    func didShowPost(at indexPath: IndexPath) {
        if indexPath.row >= cellViewModels.count - 2 {
            loadData()
        }
    }
    
    private func makeRequest(_ existingList: [CellViewModelInterface] = []) {
        guard loadingInProgress == false else { return }
        loadingInProgress = true
        
        var viewModels = existingList
        requestManager.loadTopItems(with: limit, after: after) { [weak self] (responseModel, error) in
            guard let postModels = responseModel?.data.children else { return }
            for model in postModels {
                let viewModel = CellViewModel(model: model)
                viewModels.append(viewModel)
            }
            self?.cellViewModels = viewModels
            self?.loadingInProgress = false
            
            DispatchQueue.main.async {
                self?.saveToCoreData(responseModel)
                self?.after = responseModel?.data.after
                self?.delegate?.postsDidLoad()
            }
        }
    }
}

private extension MainViewModel {
    
    func saveToCoreData(_ responseModel: ResponseModel?) {
        guard let responseModel = responseModel else { return }
        if after == nil {
            CoreDataManager.clearData()
        }
        CoreDataManager.saveResponseModel(responseModel)
        CoreDataManager.savePosts(responseModel.data.children)
    }
    
    func prepareCoreDataViewModels() {
        let models = CoreDataManager.postModels()
        var viewModels: [CellViewModelInterface] = []
        for model in models {
            let viewModel = CellViewModel(model: model)
            viewModels.append(viewModel)
        }
        self.cellViewModels = viewModels
        self.after = CoreDataManager.afterParameter()
        self.delegate?.postsDidLoad()
    }
}
