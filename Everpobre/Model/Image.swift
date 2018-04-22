import Foundation
import CoreData
import UIKit

@objc(Image)
open class Image: _Image {
  convenience init(image: UIImage, note: Note, x: Double, y: Double, width: Double, height: Double, inContext: NSManagedObjectContext){
    self.init(context: inContext)
    self.imagen = image
    self.x = x as NSNumber
    self.y = y as NSNumber
    self.height = height as NSNumber
    self.width = width as NSNumber
    self.note = note
  }
}

extension Image {
  // Custom logic goes here.
  
  var imagen: UIImage{
    get { // NSdate -> UUImage
      let img = UIImage(data: self.image as Data)
      return img!
    }
    
    set{ // UIIMage -> NSDate
      let data = UIImageJPEGRepresentation(newValue, 1)
      self.image = data! as NSData
    }
  }
}
