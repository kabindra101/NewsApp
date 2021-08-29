//
//  NewsResponse.swift
//  News
//
//  Created by Kabindra Karki on 28/08/2021.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}

struct Source: Decodable {
    let name: String
}
