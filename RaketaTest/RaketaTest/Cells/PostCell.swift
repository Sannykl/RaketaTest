//
//  PostCell.swift
//  RaketaTest
//
//  Created by mac on 29.01.2021.
//

import UIKit

class PostCell: UITableViewCell {
    
    private var viewModel: CellViewModelInterface!
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    var onImageTap: ((String) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func fill(with viewModel: CellViewModelInterface) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.titleString
        authorLabel.text = viewModel.authorString
        commentsLabel.text = viewModel.commentsString
        if let url = viewModel.thumbnailURL() {
            postImageView.loadImage(with: url, placeHolder: UIImage(named: "placeholder-image"))
        }
    }
    
    @IBAction func showFullImage(_ sender: Any) {
        guard let block = onImageTap, let url = viewModel.imageURL() else { return }
        block(url)
    }
}
