//
//  BaseLabelComponent.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
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
        text = ConstantValue.placeholderText
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 17)
        textAlignment = .left
        numberOfLines = .zero
        textColor = .white
    }
}
