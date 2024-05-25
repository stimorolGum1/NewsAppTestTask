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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
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
    
    lazy var addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить в избранное", for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var removeFromFavoriteButton: UIButton = {
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
            addToFavoriteButton.removeFromSuperview()
        } else {
            removeFromFavoriteButton.removeFromSuperview()
        }
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(newsImage)
        scrollView.addSubview(authorLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(sourceLabel)
        scrollView.addSubview(addToFavoriteButton)
        scrollView.addSubview(removeFromFavoriteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            newsImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            newsImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            newsImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            newsImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            newsImage.heightAnchor.constraint(equalToConstant: 150),
            
            authorLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 10),
            authorLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            authorLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            sourceLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            sourceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            sourceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            addToFavoriteButton.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10),
            addToFavoriteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            addToFavoriteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            addToFavoriteButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            addToFavoriteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            removeFromFavoriteButton.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10),
            removeFromFavoriteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            removeFromFavoriteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            removeFromFavoriteButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            removeFromFavoriteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    @objc func addToFavorite() {
        presenter?.addToFavoritesStorage()
    }
    
    @objc func removeFromFavorite() {
        presenter?.removeFromFavoriteStorage()
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}
