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
    // DetailView AddBookmarkButton click core data add function
    func addBookmarkButtonClick(_ item: DetailEntity?,_ isSuccess: @escaping (Bool) -> ()){
        
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.mainTitleLabel , subTitle:item?.titleLabel, content: item?.descriptionLabel, image: item?.imageView)
        
        bookmarksModel.addBookmarks(bookmarksItem) { result in
                isSuccess(result)
        }
    }
    // DetailView AddBookmarkButton click core data delete function
    func removeBookmarkButtonClick(_ item: DetailEntity?,_ isSuccess: @escaping (Bool) -> ()){
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.mainTitleLabel , subTitle: item?.titleLabel , content: item?.descriptionLabel, image: item?.imageView)
        bookmarksModel.removeBookmark(bookmarksItem) { result in
            if result{
                isSuccess(true)
            }else{
                isSuccess(false)
            }
        }
    }
    // DetailView initial bookmarkButton click delete/add control coreData is avaliable
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
