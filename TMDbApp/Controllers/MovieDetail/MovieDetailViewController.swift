//
//  MovieDetailViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

@available(iOS 11.0, *)
class MovieDetailViewController: UIViewController {
    
    // MARK: - UI Objects -
    
    lazy var titleLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        baseLabelComponent.font = UIFont.systemFont(ofSize: 24)
        return baseLabelComponent
    }()
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ConstantValue.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var ratingLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    lazy var genreLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    lazy var summaryLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 14)
        return baseLabelComponent
    }()
    lazy var castCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
    var movieDetailModel: MovieDetailModel?
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        getData()
    }
    
    func setupView() {
        updateBackgroundColor(view, ConstantValue.firstChangableColor, ConstantValue.secondChangableColor)
        view.addSubview(titleLabel)
        view.addSubview(coverImageView)
        view.addSubview(ratingLabel)
        view.addSubview(genreLabel)
        view.addSubview(summaryLabel)
        view.addSubview(castCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            coverImageView.heightAnchor.constraint(equalToConstant: 200),
            coverImageView.widthAnchor.constraint(equalToConstant: 100),
            coverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 15),
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            genreLabel.widthAnchor.constraint(equalToConstant: 250),
            genreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 15),
            summaryLabel.widthAnchor.constraint(equalToConstant: 250),
            summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            castCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            castCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            castCollectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            castCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func getData() {
        movieDetailViewModel.getMovieGenre(movieId: movieDetailModel?.movieId ?? 0, completionHandler: { [weak self] (movieGenres) in
            guard let strongSelf = self else { return }
            strongSelf.setMovieGenreList(movieGenres)
            strongSelf.castCollectionView.reloadData()
        })
    }
    
    func setMovieGenreList(_ movieGenres: [MovieGenre]) {
        var movieGenreList = [String]()
        for movieGenre in movieGenres {
            if let genre = movieGenre.name {
                movieGenreList.append(genre)
            }
        }
        let movieGenreText = movieGenreList.joined(separator: ", ")
        titleLabel.text = movieDetailModel?.movieName
        genreLabel.text = "Movie Genre(s): \(movieGenreText)"
    }
}

@available(iOS 11.0, *)
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConstantValue.movieDetailCollectionViewCellId, for: indexPath) as? MovieDetailCollectionViewCell {
            cell.castImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.castImageView.image = UIImage(named: ConstantValue.placeholderImage)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
