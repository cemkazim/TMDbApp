//
//  PopularMovieListTableViewCell.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

class PopularMovieListTableViewCell: UITableViewCell {
    
    // MARK: - UI Objects -
    
    lazy var movieImageView: BaseImageViewComponent = {
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return imageView
    }()
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, movieReleaseDateLabel])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    lazy var movieNameLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 24)
        return baseLabelComponent
    }()
    lazy var movieReleaseDateLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 15)
        return baseLabelComponent
    }()
    
    // MARK: - Lifecycles -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError(ConstantTexts.initCoderText)
    }
    
    // MARK: - Methods -
    
    func setupView() {
        addSubview(movieImageView)
        addSubview(labelStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            movieNameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            labelStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
        movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
    }
}
