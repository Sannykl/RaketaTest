//
//  CellViewModel.swift
//  RaketaTest
//
//  Created by mac on 28.01.2021.
//

import Foundation

protocol CellViewModelInterface {
    var titleString: String { get }
    var authorString: String { get }
    var commentsString: String { get }

    func thumbnailURL() -> String?
    func imageURL() -> String?
}

struct CellViewModel: CellViewModelInterface {
    private let model: PostModel
    
    var titleString: String
    var authorString: String
    var commentsString: String
    
    init(model: PostModel) {
        self.model = model
        
        titleString = model.data.title
        let dateString = CellViewModel.timeIntervalToDateString(timeInterval: TimeInterval(model.data.createdAt))

        authorString = "Posted by \(model.data.author) - \(dateString)"
        commentsString = "\(model.data.commentsCount) Comments"
    }
    
    func thumbnailURL() -> String? {
        return model.data.thumbnail.hasPrefix("https") ? model.data.thumbnail : nil
    }
    
    func imageURL() -> String? {
        return thumbnailURL() == nil ? nil : model.data.imageURL
    }
}

private extension CellViewModel {
    
    static func timeIntervalToDateString(timeInterval: TimeInterval) -> String {
        let createDate = Date(timeIntervalSince1970: timeInterval)
        let diffComponents = Calendar.current.dateComponents([.hour], from: createDate, to: Date())
        if let hours = diffComponents.hour, hours < 24 {
            return "\(hours) hours ago"
        }
        return ""
    }
}
