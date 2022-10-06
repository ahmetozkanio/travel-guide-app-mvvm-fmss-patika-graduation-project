//
//  BookmarksViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 6.10.2022.
//

import Foundation

protocol BookmarksViewModelProtocol: AnyObject{
    func reloadBookmarks()
}

final class BookmarksViewModel{
    private let bookmarksModel: BookmarksModelProtocol = BookmarksModel()
    weak var delegate: BookmarksViewModelProtocol?
    
    private var bookmarkItems: [BookmarksEntity] = []
    
    func didViewLoad(){
        initBookmarksCoreData()
    }
}

extension BookmarksViewModel{
    
    func initBookmarksCoreData(){
        bookmarksModel.getBookmarks {[weak self] (model) in
            print("Bookmarks Items")
            self?.bookmarkItems = model ?? []
            //self?.flightListItemsDelegate?.getFlightItems(model?.flights ?? [])
        } onError: { error in
            print(error ?? "Error initBookmarksCoreData")
        }
    }
}

extension BookmarksViewModel{
    func didClickItem(at item: Int) -> DetailEntity? {
        return DetailEntity(imageView: bookmarkItems[item].image, titleLabel:  bookmarkItems[item].subTitle, mainTitleLabel:  bookmarkItems[item].title, descriptionLabel:  bookmarkItems[item].content)
    }
    func getListItemCount() -> Int{
        return bookmarkItems.count
    }
    func getListCellData(indexPath: IndexPath) -> ListEntityGlobalTableViewCell? {
        return ListEntityGlobalTableViewCell(image: bookmarkItems[indexPath.row].image, title: bookmarkItems[indexPath.row].title, subTitle: bookmarkItems[indexPath.row].subTitle )
    }
}

