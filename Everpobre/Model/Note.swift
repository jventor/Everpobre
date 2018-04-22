import Foundation
import CoreData

@objc(Note)
open class Note: _Note {
  
  
}

extension Note {
  // Custom logic goes here.
  
  convenience init(title: String, text: String, notebook: Notebook, inContext: NSManagedObjectContext){
    self.init(context: inContext)
    self.title = title
    self.text = text
    self.creationDate = Date()
    self.expirationDate = Date()
    self.notebook = notebook
  }
}
