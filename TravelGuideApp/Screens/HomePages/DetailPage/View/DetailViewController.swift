//
//  DetailViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 3.10.2022.
//

import UIKit
import Kingfisher
import Toast

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    private let detailViewModel: DetailViewModel = DetailViewModel()
    
    var item: DetailEntity?
    var situationButton: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUISetup()
        configure()
        self.detailViewModelInitialBookmark()
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBookmarkButtonClicked(_ sender: Any) {
        if let item = self.item{
            if  situationButton != nil{
                if situationButton!{
                    // RemoveBookmark CoreData delete
                    detailViewModel.removeBookmarkButtonClick(item) { result in
                        if result{
                            
                            self.butonBookmarksChangeStatus(false)
                            self.view.hideToast()
                            self.view.makeToast("Bookmark Removed")
                        }
                    }
                }else{
                    // AddBookmark CoreData Add
                    detailViewModel.addBookmarkButtonClick(item) { result in
                        if result{
                            self.butonBookmarksChangeStatus(true)
                            self.view.hideToast()
                            self.view.makeToast("Bookmark Added")
                        }
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name("reloadBookmarksData"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name("reloadArticle"), object: nil)
            }
            
        }
    }
}

extension DetailViewController{
    func detailViewModelInitialBookmark(){
        detailViewModel.bookmarkInitialButton(item) { result in
            self.butonBookmarksChangeStatus(result)
        }
    }
}

extension DetailViewController{
    func butonBookmarksChangeStatus(_ situationBookmark: Bool){
        if situationBookmark{
            situationButton = situationBookmark
            bookmarkButton.setTitle("Remove Bookmark", for: .normal)
            
        }else{
            situationButton = situationBookmark
            bookmarkButton.setTitle("Add Bookmark", for: .normal)
        }
    }
}
// DetailViewInitial configure data
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
private extension DetailViewController{
    func imageUISetup(){
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}

