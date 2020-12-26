//
//  MovieDetailViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    // MARK: - UI Objects -
    
    lazy var titleLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 24)
        return baseLabelComponent
    }()
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ConstantValue.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var ratingLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        return baseLabelComponent
    }()
    lazy var releaseDateLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        return baseLabelComponent
    }()
    lazy var summaryLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 14)
        return baseLabelComponent
    }()
    lazy var castCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.register(MovieDetailCollectionViewCell.self, forCellWithReuseIdentifier: ConstantValue.movieDetailCollectionViewCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Properties -
    
    lazy var movieDetailViewModel: MovieDetailViewModel = {
        let viewModel = MovieDetailViewModel()
        return viewModel
    }()
    var movieId = 0
    var movieGenreList = [String]()
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(coverImageView)
        view.addSubview(ratingLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(summaryLabel)
        view.addSubview(castCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            coverImageView.widthAnchor.constraint(equalToConstant: 300),
            coverImageView.heightAnchor.constraint(equalToConstant: 400),
            coverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 15),
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
            releaseDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 15),
            summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func getData() {
        movieDetailViewModel.getMovieGenre(movieId: movieId, completionHandler: { [weak self] (movieGenres) in
            guard let strongSelf = self else { return }
            strongSelf.setMovieGenreList(movieGenres)
            strongSelf.castCollectionView.reloadData()
        })
    }
    
    func setMovieGenreList(_ movieGenres: [MovieGenre]) {
        for movieGenre in movieGenres {
            if let genre = movieGenre.name {
                movieGenreList.append(genre)
            }
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConstantValue.movieDetailCollectionViewCellId, for: indexPath) as? MovieDetailCollectionViewCell {
            cell.castImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//            cell.castImageView.sd_setImage(with: <#T##URL?#>, completed: <#T##SDExternalCompletionBlock?##SDExternalCompletionBlock?##(UIImage?, Error?, SDImageCacheType, URL?) -> Void#>)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
