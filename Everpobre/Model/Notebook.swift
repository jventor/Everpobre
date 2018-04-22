import Foundation
import CoreData

@objc(Notebook)
open class Notebook: _Notebook {
  
}

extension Notebook {
  // Custom logic goes here.
  
  convenience init(name: String, inContext: NSManagedObjectContext){
    self.init(context: inContext)
    self.name = name
    self.creationDate = Date()
    self.isDefault = false
  }
  

}
