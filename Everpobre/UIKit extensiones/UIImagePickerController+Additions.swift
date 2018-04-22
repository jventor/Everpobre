//
//  UIImagePickerController+Additions.swift
//  Everpobre
//
//  Created by Jaime Ventor on 21/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

extension UIImagePickerController {
  override open var shouldAutorotate: Bool {
    return true
  }
  override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    return .all
  }
}
