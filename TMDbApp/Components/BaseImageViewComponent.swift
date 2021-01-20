//
//  BaseImageViewComponent.swift
//  TMDbApp
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit

class BaseImageViewComponent: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupImageView() {
        image = UIImage(named: ConstantValue.placeholderImage)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
    }
}
