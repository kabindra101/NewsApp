//
//  NewsTableViewCell.swift
//  News
//
//  Created by Kabindra Karki on 28/08/2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    private let headLineImage: CustomImageView = {
        let img = CustomImageView(frame: .zero)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let newsTitle: ReusableLabel = {
        let lbl = ReusableLabel(title: "Furious crowd forces Justin Trudeau to cancel campaign event: 'Need freedom' - Fox News", textColor: .label, numberOfLines: 2, textAlignment: .left, font: UIFont.systemFont(ofSize: 20, weight: .semibold))
        return lbl
    }()
    
    private let authorLabel: ReusableLabel = {
        let lbl = ReusableLabel(title: "ramesh safjkajslkfjsl", textColor: .label, numberOfLines: 1, textAlignment: .left, font: UIFont.systemFont(ofSize: 17, weight: .regular))
        lbl.alpha = 0.75
        return lbl
    }()
    
    private let sourceLabel: ReusableLabel = {
        let lbl = ReusableLabel(title: "Fox News", textColor: .label, numberOfLines: 1, textAlignment: .left, font: UIFont.systemFont(ofSize: 17, weight: .regular))
        lbl.alpha = 0.45
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    func updateNews(with data: Article) {
        guard let image = data.urlToImage, let title = data.title, let author = data.author else { return }
        headLineImage.downloadImage(from: image)
        newsTitle.text = title
        authorLabel.text = author
        sourceLabel.text = data.source.name
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(headLineImage)
        headLineImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 16, bottom: 8, right: 0), size: .zero)
        headLineImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 3).isActive = true
        
        contentView.addSubview(newsTitle)
        newsTitle.anchor(top: nil, leading: headLineImage.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 16), size: .zero)
        
        let reportStack = HorizontalStackView(arrangedSubviews: [authorLabel, UIView(), sourceLabel])
        reportStack.distribution = .fill
        
        contentView.addSubview(reportStack)
        reportStack.anchor(top: nil, leading: headLineImage.trailingAnchor, bottom: headLineImage.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 16), size: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

