// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GeoPosition.swift instead.

import Foundation
import CoreData

public enum GeoPositionAttributes: String {
    case latitude = "latitude"
    case longitude = "longitude"
}

public enum GeoPositionRelationships: String {
    case note = "note"
}

open class _GeoPosition: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "GeoPosition"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _GeoPosition.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var latitude: NSNumber?

    @NSManaged open
    var longitude: NSNumber?

    // MARK: - Relationships

    @NSManaged open
    var note: Note?

}

