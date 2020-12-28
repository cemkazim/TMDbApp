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
    lazy var coverImageView: BaseImageViewComponent = {
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        imageView.layer.cornerRadius = imageView.frame.size.width / 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var ratingLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    lazy var releaseDateLabel: BaseLabelComponent = {
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
        flowLayout.itemSize = CGSize(width: 135, height: 200)
        flowLayout.estimatedItemSize = CGSize(width: 135, height: 200)
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
    
    // MARK: - View Model Property -
    
    lazy var movieDetailViewModel: MovieDetailViewModel = {
        let viewModel = MovieDetailViewModel()
        return viewModel
    }()
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        setDataToUIObjects()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    // MARK: - Methods -
    
    func setupView() {
        navigationItem.title = ConstantValue.movieDetailText
        updateBackgroundColor(view, ConstantValue.firstChangableColor, ConstantValue.secondChangableColor)
        mainScrollView.addSubview(titleLabel)
        mainScrollView.addSubview(coverImageView)
        mainScrollView.addSubview(ratingLabel)
        mainScrollView.addSubview(releaseDateLabel)
        mainScrollView.addSubview(genreLabel)
        mainScrollView.addSubview(summaryLabel)
        mainScrollView.addSubview(castCollectionView)
        view.addSubview(mainScrollView)
        view.layoutIfNeeded()
        setDataToUIObjects()
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
            
            releaseDateLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 15),
            releaseDateLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 15),
            ratingLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            genreLabel.widthAnchor.constraint(equalToConstant: 300),
            genreLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 15),
            summaryLabel.widthAnchor.constraint(equalToConstant: 300),
            summaryLabel.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            castCollectionView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 5),
            castCollectionView.heightAnchor.constraint(equalToConstant: 200),
            castCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            castCollectionView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func getData() {
        movieDetailViewModel.getMovieGenre(movieId: movieDetailViewModel.movieDetailModel?.movieId ?? 0, completionHandler: { [weak self] (movieGenres) in
            guard let strongSelf = self else { return }
            strongSelf.setMovieGenreList(movieGenres)
        })
        movieDetailViewModel.getMovieCredits(movieId: movieDetailViewModel.movieDetailModel?.movieId ?? 0, completionHandler: { [weak self] (movieCast) in
            guard let strongSelf = self else { return }
            strongSelf.movieDetailViewModel.movieCastList = movieCast
            strongSelf.setImageUrl(strongSelf.movieDetailViewModel.movieCastList)
            strongSelf.castCollectionView.reloadData()
        })
    }
    
    func setImageUrl(_ movieCastList: [MovieCast]) {
        for path in movieCastList {
            if let profilepath = path.profilePath {
                movieDetailViewModel.movieCastImageUrlList.append(APIUrl.baseMovieImageUrl + profilepath)
            }
        }
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
    
    func setDataToUIObjects() {
        mainScrollView.delegate = self
        coverImageView.sd_setImage(with: movieDetailViewModel.movieDetailModel?.movieImageUrl, completed: nil)
        titleLabel.text = movieDetailViewModel.movieDetailModel?.movieName
        summaryLabel.text = movieDetailViewModel.movieDetailModel?.overview
        if let movieRating = movieDetailViewModel.movieDetailModel?.movieVoteAverage,
           let movieReleaseDate = movieDetailViewModel.movieDetailModel?.movieReleaseDate {
            ratingLabel.text = ConstantValue.voteAverageText + "\(movieRating)" + ConstantValue.voteAverageDecimalText
            let releaseDateString = "\(movieReleaseDate)"
            releaseDateLabel.text = ConstantValue.releaseDateText + movieDetailViewModel.dateFormatter(releaseDateString)
        }
        let height = 20 + titleLabel.frame.size.width + 275 + ratingLabel.frame.size.height + releaseDateLabel.frame.size.height + genreLabel.frame.size.height + summaryLabel.frame.size.height
        mainScrollView.contentSize = CGSize(width: view.frame.size.width, height: height)
    }
}

// MARK: - MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailViewModel.movieCastList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConstantValue.movieDetailCollectionViewCellId, for: indexPath) as? MovieDetailCollectionViewCell {
            if movieDetailViewModel.movieCastImageUrlList.count > indexPath.item {
                let imageUrl = URL(string: movieDetailViewModel.movieCastImageUrlList[indexPath.item])
                cell.castImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.castImageView.sd_setImage(with: imageUrl, completed: nil)
            }
            cell.castLabel.text = movieDetailViewModel.movieCastList[indexPath.item].name
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if #available(iOS 11.0, *) {
            let personDetailViewController = PersonDetailViewController()
            if let personName = movieDetailViewModel.movieCastList[indexPath.item].name,
               let personCharacter = movieDetailViewModel.movieCastList[indexPath.item].character,
               let personKnownForDepartment = movieDetailViewModel.movieCastList[indexPath.item].knownForDepartment,
               let personProfilePath = URL(string: movieDetailViewModel.movieCastImageUrlList[indexPath.item]),
               let personGender = movieDetailViewModel.movieCastList[indexPath.item].gender,
               let personPopularity = movieDetailViewModel.movieCastList[indexPath.item].popularity {
                let personDetailModel = PersonDetailModel(personName: personName,
                                                          personCharacter: personCharacter,
                                                          personKnownForDepartment: personKnownForDepartment,
                                                          personProfilePath: personProfilePath,
                                                          personGender: personGender,
                                                          personPopularity: personPopularity)
                personDetailViewController.personDetailModel = personDetailModel
            }
            pushTo(personDetailViewController)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}
