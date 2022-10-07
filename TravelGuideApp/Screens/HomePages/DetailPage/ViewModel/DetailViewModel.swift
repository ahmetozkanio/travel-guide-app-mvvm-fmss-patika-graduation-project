//
//  DetailViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation

final class DetailViewModel{
    private let bookmarksModel: BookmarksModel = BookmarksModel()
}
extension DetailViewModel{
    
    func addBookmarkButtonClick(_ item: DetailEntity?,_ isSuccess: @escaping (Bool) -> ()){
        
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.titleLabel, subTitle: item?.mainTitleLabel, content: item?.descriptionLabel, image: item?.imageView)
        
        bookmarksModel.addBookmarks(bookmarksItem) { result in
                isSuccess(result)
        }
        

       
    }
}
