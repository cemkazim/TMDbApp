//
//  BaseLabelComponent.swift
//  TMDbApp
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit

public class BaseLabelComponent: UILabel {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setupLabel() {
        text = ConstantValue.placeholderText
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 17)
        textAlignment = .left
        numberOfLines = .zero
        textColor = .white
    }
}
