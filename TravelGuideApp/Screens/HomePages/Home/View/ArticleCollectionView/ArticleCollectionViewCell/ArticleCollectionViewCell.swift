//
//  ArticleCollectionViewCell.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.
//

import UIKit
import Kingfisher

class ArticleCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var bgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var bookmarksButton: UIButton!
    private var situationButton: Bool?
    
    private lazy var homeViewModel: HomeViewModel = HomeViewModel()
    private var articleItems: [ArticleElement]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        viewBgUI()
        bookmarksButton.addTarget(self, action: #selector(bookmarksButtonClick(sender:)), for: .touchUpInside)
    }
    
    
    @objc func bookmarksButtonClick(sender: UIButton){
        let buttonTag = sender.tag
        print(buttonTag)

        self.bookmarkButton(buttonTag)
      
    }
    @IBAction func addBookmarkButtonClicked(_ sender: Any) {
    }
}
extension ArticleCollectionViewCell{
    func bookmarkButton(_ buttonTag: Int) {
        if let item = articleItems?[buttonTag]{
           if  situationButton != nil{
                if situationButton!{
                    homeViewModel.removeBookmarkButtonClick(item) { result in
                        if result{
                            self.buttonBookmarksChangeStatus(false)
                        }else{
                            
                        }
                    }
                }else{
                    homeViewModel.addBookmarkButtonClick(item) { result in
                        if result{
                            self.buttonBookmarksChangeStatus(true)
                        }else{
                            
                        }
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name("reloadBookmarksData"), object: nil)
                //NotificationCenter.default.post(name: NSNotification.Name("reloadBookmarksData"), object: nil)
            }
           
        }
    }
}
extension ArticleCollectionViewCell{
    func articleViewInitialBookmark(_ item: ArticleElement?){
        self.homeViewModel.bookmarkInitialButton(item) { result in
            self.buttonBookmarksChangeStatus(result)
        }
    }
}
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
        imageViewBglUI()
    }
    private func imageViewBglUI(){
       // imageView.layer.cornerRadius = 8
      //  imageView.clipsToBounds = true
    }
    private func viewBgUI(){
        bgroundView.layer.cornerRadius = 8
        bgroundView.layer.shadowColor = UIColor.gray.cgColor
        bgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bgroundView.layer.shadowRadius = 7.0
        bgroundView.layer.shadowOpacity = 0.6
         //imageView.layer.cornerRadius = 8
        //imageView.clipsToBounds = true
    }
}
