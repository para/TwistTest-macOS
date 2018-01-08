import Foundation
import CoreData

@objc(CDResultItem)
class CDResultItem: NSManagedObject {
    @NSManaged public var title: String
    @NSManaged public var contents: String
    @NSManaged public var ts: NSDate
    @NSManaged public var search: CDSearchResults

    private enum Constants {
        static let entityName = "CDResultItem"
    }

    class func resultItemFetchRequest() -> NSFetchRequest<CDResultItem> {
        return NSFetchRequest<CDResultItem>(entityName: Constants.entityName)
    }

    class func insertNewResultItem(in context: NSManagedObjectContext) -> CDResultItem {
        return NSEntityDescription.insertNewObject(forEntityName: Constants.entityName, into: context) as! CDResultItem
    }
}

extension CDResultItem {
    var dataModel: ResultItem {
        return ResultItem(title: title, contents: contents, ts: ts as Date)
    }
}
