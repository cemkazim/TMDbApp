//
//  BaseLabelComponent.swift
//  TMDbComponents
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit
import TMDbUtilities

public class BaseLabelComponent: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    public required init?(coder: NSCoder) {
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
