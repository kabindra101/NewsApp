//
//  APIManager.swift
//  News
//
//  Created by Kabindra Karki on 28/08/2021.
//

import UIKit
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    public func topHeadlines(page: Int, size: Int ,completion: @escaping([Article]?, Error?) -> ()) {
        guard let apiUrl = URL(string: "\(Constants.baseURL)/top-headlines?country=us&pageSize=\(size)&apiKey=\(Constants.apiKey)") else { return }
        
        AF.request(apiUrl, method: .get).responseDecodable(of: NewsResponse.self) { response in
            guard let data =  response.value, response.error == nil else {
                print("error fetching news", response.error?.localizedDescription)
                completion(nil, response.error)
                return
            }
            completion(data.articles, nil)
        }
    }
    
}
