//
//  NewsVC.swift
//  News
//
//  Created by Kabindra Karki on 28/08/2021.
//

import UIKit
import SafariServices

class NewsVC: UIViewController {
    
    var articles: [Article] = []
    var hasMoreNews = true
    var page = 1
    var size = 20
    var isPaginating: Bool = false
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.secondarySystemBackground
        tv.separatorStyle = .none
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Top News"
        navigationController?.navigationBar.prefersLargeTitles = true
        setNavigtionBarItems()
        setupTV()
        setupViews()
        fetchData(page: page, size: size, isPaginating: false)
    }
    
    fileprivate func fetchData(page: Int, size: Int, isPaginating: Bool) {
        showLoadingView()
        if !isPaginating {
            articles.removeAll()
            tableView.reloadData()
        }
        
        APIManager.shared.topHeadlines(page: page, size: size){ [weak self] news, error in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            guard let fetchNews = news, error == nil else {
                print("error fetching market data:", error?.localizedDescription ?? "")
                return
            }
            
            if fetchNews.count < 20 {
                self.isPaginating = false
            }
            
            self.articles = fetchNews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setupTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
    }
 
    fileprivate func setNavigtionBarItems() {
            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithDefaultBackground()
                appearance.backgroundColor = UIColor(r: 236, g: 240, b: 241, a: 1)
                
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
            } else {
                // Fallback on earlier versions
                navigationController?.navigationBar.barTintColor = .brown
            }
        }
    
    fileprivate func setupViews() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let datas = articles[indexPath.row]
        cell.updateNews(with: datas)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articles = articles[indexPath.row]
        
        guard let url = URL(string: articles.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
}

extension NewsVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreNews else { return }
            page += 1
            size += 20
            fetchData(page: page, size: size, isPaginating: true)
        }
    }
}
