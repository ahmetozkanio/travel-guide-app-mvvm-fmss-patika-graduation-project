//
//  ArticleCollectionViewCell.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.
//

import UIKit
import Kingfisher
import Toast

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookmarksButton: UIButton!
    
    private var situationButton: Bool?// Checking the status of the button changes depending on whether the bookmarks are also saved.
    private lazy var homeViewModel: HomeViewModel = HomeViewModel()
    private var articleItems: [ArticleElement]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Here we listen for the button click event
        bookmarksButton.addTarget(self, action: #selector(bookmarksButtonClick(sender:)), for: .touchUpInside)
    }
    // listen for the button click event here, then we get the clicked index and save our related object
    @objc func bookmarksButtonClick(sender: UIButton){
        let buttonTag = sender.tag
        self.bookmarkButton(buttonTag)
    }
    @IBAction func addBookmarkButtonClicked(_ sender: Any) {}
}

// Adds or deletes according to the status information when the button is pressed.
extension ArticleCollectionViewCell{
    func bookmarkButton(_ buttonTag: Int) {
        if let item = articleItems?[buttonTag]{
            if  situationButton != nil{
                if situationButton!{
                    homeViewModel.removeBookmarkButtonClick(item) { result in
                        if result{
                            self.buttonBookmarksChangeStatus(false)
                            self.hideToast()
                            self.makeToast("Bookmark Removed",position: ToastPosition.center)
                        }
                    }
                }else{
                    homeViewModel.addBookmarkButtonClick(item) { result in
                        if result{
                            self.buttonBookmarksChangeStatus(true)
                            self.hideToast()
                            self.makeToast("Bookmark Added",position: ToastPosition.center)
                        }
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name("reloadBookmarksData"), object: nil)
            }
        }
    }
}

//The bookmark initial button goes and looks at the bookmarks in the database, and the process returns and reports the status, depending on whether we have an article object or not.
// Accordingly, the status information is refreshed and the button is adjusted accordingly.
extension ArticleCollectionViewCell{
    func articleViewInitialBookmark(_ item: ArticleElement?){
        self.homeViewModel.bookmarkInitialButton(item) { result in
            self.buttonBookmarksChangeStatus(result)
        }
    }
}
// Article Cell Bookmarks add/remove button events and setting process
extension ArticleCollectionViewCell{
    func buttonBookmarksChangeStatus(_ situationBookmark: Bool){
        situationButton = situationBookmark
        if situationBookmark{
            bookmarksButton.setImage(UIImage(named: "bookmarkRemove"), for: .normal)
        }else{
            bookmarksButton.setImage(UIImage(named: "bookMarkAdd"), for: .normal)
        }
    }
}
// The Article Cell is configured with the desired data.
extension ArticleCollectionViewCell{
    func configureArticleCellData(item: ArticleCellModel,articleItems: [ArticleElement],index: IndexPath){
        
        self.articleItems = articleItems
        topTitleLabel.text = item.title
        titleLabel.text = item.mainTitle
        imageView.kf.setImage(with:  URL(string: item.image!))
        bookmarksButton.tag = index.row
        
        self.articleViewInitialBookmark(articleItems[index.row])
    }
}

private extension ArticleCollectionViewCell{
    private func setupUI(){
        viewBgUI()
    }
    private func viewBgUI(){
        bgroundView.layer.cornerRadius = 8
        bgroundView.layer.shadowColor = UIColor.gray.cgColor
        bgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bgroundView.layer.shadowRadius = 7.0
        bgroundView.layer.shadowOpacity = 0.6
        bgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}
