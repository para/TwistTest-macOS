import Foundation
import CoreData

@objc(CDSearchResults)
class CDSearchResults: NSManagedObject {
    @NSManaged public var query: String
    @NSManaged public var ts: NSDate
    @NSManaged public var items: NSSet?

    private enum Constants {
        static let entityName = "CDSearchResults"
    }

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CDResultItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CDResultItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

    class func searchResultsFetchRequest() -> NSFetchRequest<CDSearchResults> {
        return NSFetchRequest<CDSearchResults>(entityName: Constants.entityName)
    }

    class func insertNewSearchResults(in context: NSManagedObjectContext) -> CDSearchResults {
        return NSEntityDescription.insertNewObject(forEntityName: Constants.entityName, into: context) as! CDSearchResults
    }
}

extension CDSearchResults {
    var dataModel: SearchResults {
        var resultItems = [ResultItem]()
        if let items = items {
            for item in items {
                if let item = item as? CDResultItem {
                    resultItems.append(item.dataModel)
                }
            }
        }
        return SearchResults(query: query, ts: ts as Date, items: resultItems)
    }
}
