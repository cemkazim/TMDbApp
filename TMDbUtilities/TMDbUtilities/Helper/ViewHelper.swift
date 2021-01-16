//
//  BaseViewTool.swift
//  TMDbUtilities
//
//  Created by Cem Kazım on 16.01.2021.
//

import UIKit

extension UIViewController {
    
    public func pushTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func updateBackgroundColor(_ view: UIView, _ firstColor: CGColor, _ secondColor: CGColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            firstColor,
            secondColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
        let gradientChangeAnimation = CABasicAnimation(keyPath: ConstantValue.colorsKeyPath)
        gradientChangeAnimation.duration = 2.5
        gradientChangeAnimation.toValue = [
            secondColor,
            firstColor
        ]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: ConstantValue.colorChangeKey)
    }
    
    public func removeNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
