//
//  Image.swift
//  Everpobre
//
//  Created by Jaime Ventor on 21/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

struct Image {
  var image : UIImage
  var x : CGFloat
  var y : CGFloat
  var width : Double
  var height : Double
  
  init(image: UIImage, x: CGFloat, y : CGFloat, width: Double, height: Double) {
    self.image = image
    self.x = x
    self.y = y
    self.width = width
    self.height = height
  }
}
