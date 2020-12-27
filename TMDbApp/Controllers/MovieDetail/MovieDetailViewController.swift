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
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        flowLayout.estimatedItemSize = CGSize(width: 150, height: 150)
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieDetailCollectionViewCell.self, forCellWithReuseIdentifier: ConstantValue.movieDetailCollectionViewCellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = UIView.init(frame: .zero)
        return collectionView
    }()
    
    // MARK: - Properties -
    
    lazy var movieDetailViewModel: MovieDetailViewModel = {
        let viewModel = MovieDetailViewModel()
        return viewModel
    }()
    var movieDetailModel: MovieDetailModel?
    var movieCastList = [MovieCast]()
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        mainScrollView.delegate = self
        coverImageView.sd_setImage(with: movieDetailModel?.movieImageUrl, completed: nil)
        titleLabel.text = movieDetailModel?.movieName
        summaryLabel.text = movieDetailModel?.overview
        let height = 15 + titleLabel.frame.size.width + 200 + ratingLabel.frame.size.height + genreLabel.frame.size.height + summaryLabel.frame.size.height
        mainScrollView.contentSize = CGSize(width: view.frame.size.width, height: height)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    // MARK: - Methods -
    
    func setupView() {
        updateBackgroundColor(view, ConstantValue.firstChangableColor, ConstantValue.secondChangableColor)
        mainScrollView.addSubview(titleLabel)
        mainScrollView.addSubview(coverImageView)
        mainScrollView.addSubview(ratingLabel)
        mainScrollView.addSubview(genreLabel)
        mainScrollView.addSubview(summaryLabel)
        mainScrollView.addSubview(castCollectionView)
        view.addSubview(mainScrollView)
        view.layoutIfNeeded()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            coverImageView.heightAnchor.constraint(equalToConstant: 200),
            coverImageView.widthAnchor.constraint(equalToConstant: 100),
            coverImageView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 15),
            ratingLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            genreLabel.widthAnchor.constraint(equalToConstant: 250),
            genreLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 15),
            summaryLabel.widthAnchor.constraint(equalToConstant: 250),
            summaryLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            castCollectionView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 5),
            castCollectionView.heightAnchor.constraint(equalToConstant: 150),
            castCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            castCollectionView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func getData() {
        movieDetailViewModel.getMovieGenre(movieId: movieDetailModel?.movieId ?? 0, completionHandler: { [weak self] (movieGenres) in
            guard let strongSelf = self else { return }
            strongSelf.setMovieGenreList(movieGenres)
        })
        movieDetailViewModel.getMovieCredits(movieId: movieDetailModel?.movieId ?? 0, completionHandler: { [weak self] (movieCast) in
            guard let strongSelf = self else { return }
            strongSelf.movieCastList = movieCast
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
        genreLabel.text = "Movie Genre(s): \(movieGenreText)"
    }
}

// MARK: - MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

@available(iOS 11.0, *)
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCastList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConstantValue.movieDetailCollectionViewCellId, for: indexPath) as? MovieDetailCollectionViewCell {
            let imageUrl = URL(string: movieDetailViewModel.movieCastImageUrlList[indexPath.item])
            cell.castImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.castImageView.sd_setImage(with: imageUrl, completed: nil)
            cell.castLabel.text = movieCastList[indexPath.item].name
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let personDetailViewController = PersonDetailViewController()
        if let personName = movieCastList[indexPath.item].name,
           let personCharacter = movieCastList[indexPath.item].character,
           let personKnownForDepartment = movieCastList[indexPath.item].knownForDepartment,
           let personProfilePath = URL(string: movieDetailViewModel.movieCastImageUrlList[indexPath.item]),
           let personGender = movieCastList[indexPath.item].gender,
           let personPopularity = movieCastList[indexPath.item].popularity {
            let personDetailModel = PersonDetailModel(personName: personName,
                                                      personCharacter: personCharacter,
                                                      personKnownForDepartment: personKnownForDepartment,
                                                      personProfilePath: personProfilePath,
                                                      personGender: personGender,
                                                      personPopularity: personPopularity)
            personDetailViewController.personDetailModel = personDetailModel
        }
        pushTo(personDetailViewController)
    }
}
