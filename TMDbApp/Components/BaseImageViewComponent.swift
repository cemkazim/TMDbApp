//
//  BaseImageViewComponent.swift
//  TMDbApp
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit

public class BaseImageViewComponent: UIImageView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setupImageView() {
        image = UIImage(named: ConstantValue.placeholderImage)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
    }
}
