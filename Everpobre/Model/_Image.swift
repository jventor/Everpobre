// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Image.swift instead.

import Foundation
import CoreData

public enum ImageAttributes: String {
    case height = "height"
    case image = "image"
    case width = "width"
    case x = "x"
    case y = "y"
}

public enum ImageRelationships: String {
    case note = "note"
}

open class _Image: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Image"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Image.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var height: NSNumber?

    @NSManaged open
    var image: NSData

    @NSManaged open
    var width: NSNumber?

    @NSManaged open
    var x: NSNumber?

    @NSManaged open
    var y: NSNumber?

    // MARK: - Relationships

    @NSManaged open
    var note: Note

}

