//
//  BaseImageViewComponent.swift
//  TMDbComponents
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit
import Utilities

public class BaseImageViewComponent: UIImageView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setupImageView() {
        image = UIImage(named: ConstantValue.placeholderImage)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
    }
}
