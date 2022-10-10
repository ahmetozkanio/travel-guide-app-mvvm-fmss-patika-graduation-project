//
//  ArticleViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.
//

import Foundation

//MARK: HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject{
    func articleItemsReload()
}

//MARK: HomeViewModel
final class HomeViewModel {
    
    weak var delegate: HomeViewModelProtocol?
    private let articleService: HomeModelProtocol = HomeModel()
    private let detailViewController: DetailViewController = DetailViewController()
    private let bookmarksModel: BookmarksModel = BookmarksModel()
    let homeViewController: HomeViewController = HomeViewController()
    private lazy var articleItems: [ArticleElement] = []
    
    init(){}
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
    // When the page is opened for the first time, a request is sent to the article service and the list is populated.
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
    //is added from the database along with the requested data
    func addBookmarkButtonClick(_ item: ArticleElement?,_ isSuccess: @escaping (Bool) -> ()){
        
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.title , subTitle:item?.author, content: item?.content, image: item?.urlToImage)
        bookmarksModel.addBookmarks(bookmarksItem) { result in
            isSuccess(result)
        }
    }
    // is removed from the database along with the requested data
    func removeBookmarkButtonClick(_ item: ArticleElement?,_ isSuccess: @escaping (Bool) -> ()){
        let bookmarksItem = BookmarksEntity(id: UUID(),title: item?.title , subTitle:item?.author, content: item?.content, image: item?.urlToImage)
        bookmarksModel.removeBookmark(bookmarksItem) { result in
            if result{
                isSuccess(true)
            }else{
                isSuccess(false)
            }
        }
    }
    //The bookmark initial button goes and looks at the bookmarks in the database, and the process returns and reports the status, depending on whether we have an article object or not.
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
        }
    }
}
