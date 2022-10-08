//
//  ArticleViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject{
    func articleItemsReload()
}


final class HomeViewModel {
    
    weak var delegate: HomeViewModelProtocol?
    private let articleService: HomeModelProtocol = HomeModel()
    private let detailViewController: DetailViewController = DetailViewController()
    private let bookmarksModel: BookmarksModel = BookmarksModel()
    let homeViewController: HomeViewController = HomeViewController()
    
    private lazy var articleItems: [ArticleElement] = []
    
    init(){
        
    }
    func didViewLoad(){
        initArticleService()
    }
}

extension HomeViewModel{
    func didClickItem(at item: Int) -> ArticleElement? {
        return articleItems[item]
    }
    
}
extension HomeViewModel{
    
    func getArticleItemCount() -> Int{
        return articleItems.count
    }
    func getArticleCellData(indexPath: IndexPath) -> ArticleCellModel? {
        return ArticleCellModel(title: articleItems[indexPath.row].author, mainTitle:articleItems[indexPath.row].title , image: articleItems[indexPath.row].urlToImage)
    }
    func getArticleElementModel() -> [ArticleElement]? {
        return articleItems
    }
    func initArticleService(){
        articleService.fetchArticles {[weak self] (models) in
            self?.articleItems = (models?.articles)!
            self?.delegate?.articleItemsReload()
        } onError: { error in
            print(error ?? "Error initArticleService")
        }
    }
}

extension HomeViewModel{
    func addBookmarkButtonClick(_ item: ArticleElement?,_ isSuccess: @escaping (Bool) -> ()){
        
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.title , subTitle:item?.author, content: item?.content, image: item?.urlToImage)
        bookmarksModel.addBookmarks(bookmarksItem) { result in
                isSuccess(result)
          //  self.bookmarksViewModel.reloadDataInit()
        }
    }
    
    func removeBookmarkButtonClick(_ item: ArticleElement?,_ isSuccess: @escaping (Bool) -> ()){
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.title , subTitle:item?.author, content: item?.content, image: item?.urlToImage)
        bookmarksModel.removeBookmark(bookmarksItem) { result in
            if result{
                isSuccess(true)
               // self.bookmarksViewModel.reloadDataInit()
            }else{
                isSuccess(false)
            }
        }
    }
    
    func bookmarkInitialButton(_ item: ArticleElement?,_ isSuccess: @escaping (Bool) -> ()){
        if item != nil{
            bookmarksModel.getBookmarks { bookmarks in
                if let bookmarks = bookmarks{
                    for bookmark in bookmarks{
                        if item?.title == bookmark.title{
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
