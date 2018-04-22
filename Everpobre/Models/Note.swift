//
//  Note.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

final class Note {
  var title : String
  var creationDate : Date
  var expirationDate : Date
  var text : String
  //var geoposition :
  var images : [Image]
  weak var notebook : Notebook?
  
  init(title: String, creationDate: Date, expirationDate: Date, text: String, images: [Image], notebook: Notebook?) {
    self.title = title
    self.creationDate = creationDate
    self.expirationDate = expirationDate
    self.text = text
    self.images = images
    self.notebook = notebook
  }
  
  init(){
    self.title = "New note"
    self.creationDate = Date()
    self.expirationDate = Date()
    self.text = ""
    self.images = []
    self.notebook = nil
  }
  
  init(notebook: Notebook){
    self.title = "New note"
    self.creationDate = Date()
    self.expirationDate = Date()
    self.text = ""
    self.images = []
    self.notebook = notebook
  }
}
