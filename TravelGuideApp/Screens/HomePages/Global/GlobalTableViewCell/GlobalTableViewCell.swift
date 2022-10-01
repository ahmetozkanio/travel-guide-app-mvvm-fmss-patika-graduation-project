//
//  GlobalTableViewCell.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.
//

import UIKit

class GlobalTableViewCell: UITableViewCell {

    @IBOutlet weak var tagLabel: UILabel!
 
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imageViewBg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

private extension GlobalTableViewCell{
    private func setupUI()
    {
        tagLabelUI()
        imageViewBglUI()
    }
    private func imageViewBglUI(){
        
        
      
        
        viewBg.layer.cornerRadius = 8
        viewBg.layer.shadowColor = UIColor.gray.cgColor
        viewBg.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        viewBg.layer.shadowRadius = 4.0
        viewBg.layer.shadowOpacity = 1
        imageViewBg.layer.cornerRadius = 8
        imageViewBg.clipsToBounds = true
        
       // imageViewBg.layer.cornerRadius = 8.0
    }
    private func tagLabelUI(){
        tagLabel.layer.cornerRadius = 4.0
    }
}
