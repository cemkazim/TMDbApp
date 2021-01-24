//
//  MovieDetailViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, MovieDetailViewModelDelegate {
    
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
        collectionView.register(MovieDetailCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.movieDetailCollectionViewCellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = UIView.init(frame: .zero)
        return collectionView
    }()
    
    // MARK: - Properties -
    
    var movieDetailViewModel: MovieDetailViewModel?
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getDataFrom(movieDetailViewModel?.movieResults)
    }
    
    override func viewDidLayoutSubviews() {
        resizeScrollView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    // MARK: - Methods -
    
    func setupView() {
        navigationItem.title = ConstantTexts.movieDetailText
        movieDetailViewModel?.delegate = self
        updateBackgroundColor(view, CustomColors.firstChangableColor, CustomColors.secondChangableColor)
        mainScrollView.addSubview(titleLabel)
        mainScrollView.addSubview(coverImageView)
        mainScrollView.addSubview(ratingLabel)
        mainScrollView.addSubview(releaseDateLabel)
        mainScrollView.addSubview(summaryLabel)
        mainScrollView.addSubview(castCollectionView)
        view.addSubview(mainScrollView)
        setupConstraints()
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
            
            summaryLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 15),
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
    
    func getDataFrom(_ movieResult: MovieResults?) {
        if let title = movieResult?.title,
           let imageUrl = URL(string: APIParam.movieImageUrl.rawValue + (movieResult?.posterPath ?? "")),
           let releaseDate = movieResult?.releaseDate,
           let summary = movieResult?.overview {
            titleLabel.text = title
            coverImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            coverImageView.sd_setImage(with: imageUrl, completed: nil)
            releaseDateLabel.text = ConstantTexts.releaseDateText + (movieDetailViewModel?.dateFormatter(releaseDate) ?? DateFormats.birthOfChrist)
            ratingLabel.text = ConstantTexts.voteAverageText + "\(movieResult?.voteAverage ?? 0.0)" + ConstantTexts.voteAverageDecimalText
            summaryLabel.text = summary
        } else {
            titleLabel.text = ConstantTexts.unknownText
            coverImageView.image = UIImage(named: ImageNames.placeholder)
            releaseDateLabel.text = ConstantTexts.unknownText
            summaryLabel.text = ConstantTexts.unknownText
        }
    }
    
    func resizeScrollView() {
        let height = titleLabel.frame.size.width + ratingLabel.frame.size.height + releaseDateLabel.frame.size.height + summaryLabel.frame.size.height + 280
        mainScrollView.contentSize = CGSize(width: view.frame.size.width, height: height)
    }
    
    func setMovieCast(_ personDetailList: [PersonDetailModel]) {
        movieDetailViewModel?.personDetailList = personDetailList
        setImageUrl(personDetailList)
        castCollectionView.reloadData()
    }
    
    func setImageUrl(_ movieCastList: [PersonDetailModel]) {
        for path in movieCastList {
            checkImageUrl(from: path)
        }
    }
    
    func checkImageUrl(from path: PersonDetailModel) {
        if path.profilePath != nil {
            let model = CastModel(name: path.name ?? "", imagePath: APIParam.movieImageUrl.rawValue + (path.profilePath ?? ""))
            movieDetailViewModel?.castList.append(model)
        } else {
            let model = CastModel(name: path.name ?? "", imagePath: nil)
            movieDetailViewModel?.castList.append(model)
        }
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
        return movieDetailViewModel?.castList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.movieDetailCollectionViewCellId, for: indexPath) as? MovieDetailCollectionViewCell {
            if let imageUrl = URL(string: movieDetailViewModel?.castList[indexPath.item].imagePath ?? "") {
                cell.castImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.castImageView.sd_setImage(with: imageUrl)
            } else {
                cell.castImageView.image = UIImage(named: ImageNames.placeholderProfile)
            }
            cell.castLabel.text = movieDetailViewModel?.castList[indexPath.item].name
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = PersonDetailViewController()
        if let model = movieDetailViewModel?.personDetailList[indexPath.row] {
            let viewModel = PersonDetailViewModel(personDetailModel: model)
            viewController.personDetailViewModel = viewModel
        }
        pushTo(viewController)
    }
}
