//
//  Notebook.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import Foundation

final class Notebook {
  var name : String
  var creationDate : Date
  var notes : [Note]
  
  init(name: String, creationDate: Date, notes: [Note]) {
    self.name = name
    self.creationDate = creationDate
    self.notes = notes
  }
  
  init() {
    self.name = "New notebook"
    self.creationDate = Date()
    self.notes = []
  }
  
}
