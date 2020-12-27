//
//  MovieListTableViewCell.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - UI Objects -
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: ConstantValue.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, movieGenreLabel])
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
    lazy var movieGenreLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 15)
        return baseLabelComponent
    }()
    
    // MARK: - Lifecycles -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(ConstantValue.initCoderText)
    }
    
    // MARK: - Methods -
    
    func setupView() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(labelStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            movieNameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            labelStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            labelStackView.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
        ])
    }
}
