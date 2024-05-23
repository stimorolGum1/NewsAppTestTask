//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Danil on 21.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenter?
    var isfavoriteButtonHide: Bool?
    
    lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить в избранное", for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var removeFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Убрать из избранного", for: .normal)
        button.addTarget(self, action: #selector(removeFromFavorite), for: .touchUpInside)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        presenter?.setData()
        if isfavoriteButtonHide == true {
            favoriteButton.isHidden = true
        } else {
            removeFavoriteButton.isHidden = true
        }
    }
    
    func setupViews() {
        view.addSubview(authorLabel)
        view.addSubview(newsImage)
        view.addSubview(descriptionLabel)
        view.addSubview(sourceLabel)
        view.addSubview(favoriteButton)
        view.addSubview(removeFavoriteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            newsImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            newsImage.heightAnchor.constraint(equalToConstant: 150),
            
            authorLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 200),
            
            sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            sourceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            sourceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            sourceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            favoriteButton.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10),
            favoriteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            
            removeFavoriteButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10),
            removeFavoriteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            removeFavoriteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            removeFavoriteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func addToFavorite() {
        presenter?.addToFavoritesStorage()
    }
    
    @objc func removeFromFavorite() {
        presenter?.removeFromFavorite()
    }
}
