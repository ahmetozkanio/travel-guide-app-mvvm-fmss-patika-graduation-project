//
//  DetailViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 3.10.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: ArticleElement?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUISetup()
        configure()
    }
    

    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addBookmarkButtonClicked(_ sender: Any) {
    }
}
extension DetailViewController{
    func configure(){
        if item != nil {
            titleLabel.text = item?.author
            mainTitleLabel.text = item?.title
            imageView.kf.setImage(with: URL(string: (item?.urlToImage)!))
        }
    }
}

private extension DetailViewController{
    func imageUISetup(){
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}

