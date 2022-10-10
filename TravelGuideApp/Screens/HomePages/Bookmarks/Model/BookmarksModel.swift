//
//  BookmarksModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 6.10.2022.
//

import Foundation
import CoreData.NSManagedObject

//MARK: BookmarksModelProtocol
protocol BookmarksModelProtocol: AnyObject{
    func getBookmarks(onSuccess: @escaping ([BookmarksEntity]?) -> (), onError: @escaping (String?) -> ())
    func addBookmarks(_ bookmarkItem: BookmarksEntity? ,onSuccess: @escaping (Bool) -> ())
}
//MARK: BookmarksModel
final class BookmarksModel{
    private let entityName = "Bookmarks"
    private var bookmarkList: [BookmarksEntity] = []
    
    // Data from CoreData is called according to entityName and converted to list. And it is sent to the place called
    func getBookmarks(onSuccess: @escaping ([BookmarksEntity]?) -> (), onError: @escaping (String?) -> ()) {
        CoreDataManager.shared.getCoreData("Bookmarks") { [self] results in
            bookmarkList.removeAll()
            for result in results as! [NSManagedObject]{
                self.bookmarkList.append(
                    BookmarksEntity(id: result.value(forKey: "id") as? UUID , title: result.value(forKey: "title") as? String, subTitle: result.value(forKey: "subTitle") as? String, content: result.value(forKey: "content") as? String, image: result.value(forKey: "image") as? String)
                )
            }
            onSuccess(bookmarkList.reversed())
        } onError: { error in
            onError(error)
        }
    }
    //Bookmark item is requested and accordingly the addition process takes place.
    func addBookmarks(_ bookmarkItem: BookmarksEntity? ,onSuccess: @escaping (Bool) -> ()) {
        CoreDataManager.shared.setCoreData(bookmarkItem, self.entityName) { result in
            if result{
                onSuccess(true)
            }
        } onError: { error in
            onSuccess(false)
            print(error ?? "")
        }
    }
    //The Bookmark Entity is requested and deleted accordingly.
    func removeBookmark(_ bookmarkItem: BookmarksEntity? ,onSuccess: @escaping (Bool) -> ()){
        CoreDataManager.shared.deleteBookmark(bookmarkItem, entityName) { result in
            if result{
                onSuccess(true)
            }else{
                onSuccess(false)
            }
            
        }
    }
}
