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
    func initArticleService(){
        articleService.fetchArticles {[weak self] (models) in
            self?.articleItems = (models?.articles)!
            self?.delegate?.articleItemsReload()
        } onError: { error in
            print(error ?? "Error initArticleService")
        }
        
    }
}
