//
//  String+Additions.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import Foundation

extension String{
  func toDate( format: String) -> Date? {
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = format
    return dateStringFormatter.date(from: self)
  }
}
