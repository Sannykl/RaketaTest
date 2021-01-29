//
//  ImageViewController.swift
//  RaketaTest
//
//  Created by mac on 29.01.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageURL: String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = imageURL else { return }
        imageView.loadImage(with: url, placeHolder: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
