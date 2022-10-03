//
//  ArticleModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.


protocol HomeModelProtocol: AnyObject{
    func fetchArticles(onSuccess: @escaping (Article?) -> (), onError: @escaping (String?) -> ())
}

final class HomeModel: HomeModelProtocol{
   
    func fetchArticles(onSuccess: @escaping (Article?) -> (), onError: @escaping (String?) -> ()) {
        ServiceManager.shared.fetch(path: Constant.ArticleServiceEndPoint.articleEndPoint()) { (response: Article) in
            onSuccess(response)
        } onError: { error in
           onError(error)
        }
    }
    
}


