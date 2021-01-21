//
//  BaseLabelComponent.swift
//  TMDbApp
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit

class BaseLabelComponent: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLabel() {
        text = ConstantTexts.placeholderText
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 17)
        textAlignment = .left
        numberOfLines = .zero
        textColor = .white
    }
}
