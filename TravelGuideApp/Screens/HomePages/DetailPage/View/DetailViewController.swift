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
    
    private let detailViewModel: DetailViewModel = DetailViewModel()
    
    var item: DetailEntity?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUISetup()
        configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(successAddBookmark), name: Notification.Name("addBookmark"), object: nil)
    }
    @objc func successAddBookmark(){
        
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addBookmarkButtonClicked(_ sender: Any) {
        if let item = self.item{
  
            detailViewModel.addBookmarkButtonClick(item) { result in
                if result{
                    
                }else{
                    
                }
            }
        }
    }
}
extension DetailViewController{
    func configure(){
        if item != nil {
            titleLabel.text = item?.titleLabel
            mainTitleLabel.text = item?.mainTitleLabel
            descriptionLabel.text = item?.descriptionLabel
            imageView.kf.setImage(with: URL(string: (item?.imageView)!))
        }
    }
}
extension DetailViewController{
    func butonBookmarksChangeStatus(){
        
    }
}


private extension DetailViewController{
    func imageUISetup(){
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}

