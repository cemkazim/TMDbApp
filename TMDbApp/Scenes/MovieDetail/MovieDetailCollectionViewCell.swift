//
//  MovieDetailCollectionViewCell.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Objects -
    
    lazy var castImageView: BaseImageViewComponent = {
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        imageView.layer.cornerRadius = imageView.frame.size.width / 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var castLabel: BaseLabelComponent = {
        let label = BaseLabelComponent()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycles -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(ConstantTexts.initCoderText)
    }
    
    // MARK: - Methods -
    
    func setupView() {
        addSubview(castImageView)
        addSubview(castLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            castImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            castImageView.widthAnchor.constraint(equalToConstant: 120),
            castImageView.heightAnchor.constraint(equalToConstant: 120),
            castImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            castLabel.topAnchor.constraint(equalTo: castImageView.bottomAnchor, constant: 10),
            castLabel.widthAnchor.constraint(equalToConstant: 75),
            castLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
