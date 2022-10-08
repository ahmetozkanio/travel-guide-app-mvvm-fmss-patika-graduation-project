//
//  DetailViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation

final class DetailViewModel{
    private let bookmarksModel: BookmarksModel = BookmarksModel()
   // private let bookmarksViewModel: BookmarksViewModel = BookmarksViewModel()
}
extension DetailViewModel{
    
    
    func addBookmarkButtonClick(_ item: DetailEntity?,_ isSuccess: @escaping (Bool) -> ()){
        
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.mainTitleLabel , subTitle:item?.titleLabel, content: item?.descriptionLabel, image: item?.imageView)
        bookmarksModel.addBookmarks(bookmarksItem) { result in
                isSuccess(result)
          //  self.bookmarksViewModel.reloadDataInit()
        }
    }
    
    func removeBookmarkButtonClick(_ item: DetailEntity?,_ isSuccess: @escaping (Bool) -> ()){
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.mainTitleLabel , subTitle: item?.titleLabel , content: item?.descriptionLabel, image: item?.imageView)
        bookmarksModel.removeBookmark(bookmarksItem) { result in
            if result{
                isSuccess(true)
               // self.bookmarksViewModel.reloadDataInit()
            }else{
                isSuccess(false)
            }
        }
    }
    
    func bookmarkInitialButton(_ item: DetailEntity?,_ isSuccess: @escaping (Bool) -> ()){
        if item != nil{
            bookmarksModel.getBookmarks { bookmarks in
                if let bookmarks = bookmarks{
                    for bookmark in bookmarks{
                        if item?.mainTitleLabel == bookmark.title{
                            isSuccess(true)
                            return
                        }
                    }
                   isSuccess(false)
                }
            } onError: { error in
                print(error ?? " ERROR ")
            }

        }else{
            print("item nil")
        }
   
        
    }
}
