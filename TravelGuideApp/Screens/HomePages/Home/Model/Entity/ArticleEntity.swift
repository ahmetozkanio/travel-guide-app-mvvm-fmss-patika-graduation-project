//
//  ArticleEntity.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 2.10.2022.
//


import Foundation
// MARK: - Article
struct Article: Codable {
    let articles: [ArticleElement]?
}

// MARK: - ArticleElement
struct ArticleElement: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
}

