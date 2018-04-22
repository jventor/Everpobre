//
//  UIViewController+Additions.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

extension UIViewController {
  func wrappedInNavigation() -> UINavigationController {
    return UINavigationController(rootViewController: self)
  }
}
