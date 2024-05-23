//
//  NewsCell.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import UIKit

class NewsCell: UITableViewCell {
    
    lazy var imageNews: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var discribeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(imageNews)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(discribeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageNews.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageNews.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageNews.heightAnchor.constraint(equalToConstant: 40),
            imageNews.widthAnchor.constraint(equalToConstant: 40),
            
            authorLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: imageNews.trailingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: imageNews.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            discribeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            discribeLabel.leadingAnchor.constraint(equalTo: imageNews.trailingAnchor, constant: 10),
            discribeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            discribeLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
