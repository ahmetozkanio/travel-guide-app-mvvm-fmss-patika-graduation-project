//
//  BookmarksModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 6.10.2022.
//

import Foundation
import CoreData.NSManagedObject

protocol BookmarksModelProtocol: AnyObject{
    func getBookmarks(onSuccess: @escaping ([BookmarksEntity]?) -> (), onError: @escaping (String?) -> ())
    func addBookmarks(onSuccess: @escaping (Bool) -> (), onError: @escaping (String?) -> ())
}

final class BookmarksModel: BookmarksModelProtocol{
    private let entityName = "Bookmarks"
    private var bookmarkList: [BookmarksEntity] = []
    
    func getBookmarks(onSuccess: @escaping ([BookmarksEntity]?) -> (), onError: @escaping (String?) -> ()) {
        CoreDataManager.shared.getCoreData("Bookmarks") { [self] results in
            for result in results as! [NSManagedObject]{
                self.bookmarkList.append(
                    BookmarksEntity(id: result.value(forKey: "id") as? UUID , title: result.value(forKey: "title") as? String, subTitle: result.value(forKey: "subTitle") as? String, content: result.value(forKey: "content") as? String, image: result.value(forKey: "image") as? String)
                )
            }
            onSuccess(bookmarkList)
        } onError: { error in
            onError(error)
        }
    }
    func addBookmarks(onSuccess: @escaping (Bool) -> (), onError: @escaping (String?) -> ()) {
        CoreDataManager.shared.getCoreData("Bookmarks") { [self] results in
            for result in results as! [NSManagedObject]{
                self.bookmarkList.append(
                    BookmarksEntity(id: result.value(forKey: "id") as? UUID , title: result.value(forKey: "title") as? String, subTitle: result.value(forKey: "subTitle") as? String, content: result.value(forKey: "content") as? String, image: result.value(forKey: "image") as? String)
                )
            }
            onSuccess(true)
        } onError: { error in
            onError(error)
        }
    }
    
   
  
}
