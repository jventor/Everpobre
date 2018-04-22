import Foundation
import CoreData

@objc(GeoPosition)
open class GeoPosition: _GeoPosition {
  
}

extension GeoPosition {

  convenience init(latitude: Double, longitude: Double, note: Note, inContext: NSManagedObjectContext){
    self.init(context: inContext)
    self.latitude = latitude as NSNumber
    self.longitude = longitude as NSNumber
    self.note = note
  }
}
