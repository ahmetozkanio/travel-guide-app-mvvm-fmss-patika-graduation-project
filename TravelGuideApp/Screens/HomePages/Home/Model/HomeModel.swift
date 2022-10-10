//
//  ArticleModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.

// MARK: HomeModelProtocol
protocol HomeModelProtocol: AnyObject{
    func fetchArticles(onSuccess: @escaping (Article?) -> (), onError: @escaping (String?) -> ())
}
// MARK: HomeModel
final class HomeModel: HomeModelProtocol{
    
    // Article models is fetch
    func fetchArticles(onSuccess: @escaping (Article?) -> (), onError: @escaping (String?) -> ()) {
        ServiceManager.shared.fetch(path: Constant.ArticleServiceEndPoint.articleGetEndPoint()) { (response: Article) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}


