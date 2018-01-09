import Foundation
import CoreData

@objc(CDLoggedUser)
class CDLoggedUser: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var timeZone: String
    @NSManaged public var token: String

    private enum Constants {
        static let entityName = "CDLoggedUser"
    }

    class func loggedUserFetchRequest() -> NSFetchRequest<CDLoggedUser> {
        return NSFetchRequest<CDLoggedUser>(entityName: Constants.entityName)
    }

    class func insertNewLoggedUser(in context: NSManagedObjectContext) -> CDLoggedUser {
        return NSEntityDescription.insertNewObject(forEntityName: Constants.entityName, into: context) as! CDLoggedUser
    }
}

extension CDLoggedUser {
    var dataModel: LoggedUser {
        return LoggedUser(name: name, timeZone: timeZone, token: token)
    }
}
