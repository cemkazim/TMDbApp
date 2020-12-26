//
//  BaseViewTool.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import UIKit

extension UIViewController {
    
    func pushTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
