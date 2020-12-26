//
//  MovieDetailCollectionViewCell.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {
    
    lazy var castImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ConstantValue.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var castLabel: BaseLabelComponent = {
        let label = BaseLabelComponent()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError(ConstantValue.initCoderText)
    }
    
    func setupView() {
        addSubview(castImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            castImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            castImageView.widthAnchor.constraint(equalToConstant: 150),
            castImageView.heightAnchor.constraint(equalToConstant: 100),
            castImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            castLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            castLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
