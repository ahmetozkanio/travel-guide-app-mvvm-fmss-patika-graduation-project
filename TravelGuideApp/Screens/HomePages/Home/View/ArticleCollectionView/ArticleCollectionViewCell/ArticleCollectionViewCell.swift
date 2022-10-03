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
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        viewBgUI()
    }

    @IBAction func addBookmarkButtonClicked(_ sender: Any) {
    }
}

extension ArticleCollectionViewCell{
    func configureArticleCellData(item: ArticleCellModel){
        topTitleLabel.text = item.title
        titleLabel.text = item.mainTitle
        imageView.kf.setImage(with:  URL(string: item.image!))
    }
}

private extension ArticleCollectionViewCell{
    private func setupUI()
    {
   
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
