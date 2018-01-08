import Cocoa

class CoreDataDataSource: DataSource {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AlbesTwist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error while loading persistent stores: \(error)")
            }
        })
        return container
    }()

    func getLoggedUser() -> LoggedUser? {
        let context = persistentContainer.viewContext
        let userFetchRequest = CDLoggedUser.loggedUserFetchRequest()
        do {
            let fetchedUsers = try context.fetch(userFetchRequest)
            return fetchedUsers.first?.dataModel
        } catch {
            fatalError("Failed to fetch CDLoggedUser objects")
        }
    }

    func saveLoggedUser(_ user: LoggedUser) {
        let context = persistentContainer.viewContext
        let newLoggedUser = CDLoggedUser.insertNewLoggedUser(in: context)
        newLoggedUser.name = user.name
        newLoggedUser.timeZone = user.timeZone
        newLoggedUser.token = user.token
        saveContext()
    }

    func deleteLoggedUser() {
        let context = persistentContainer.viewContext
        let userFetchRequest = CDLoggedUser.loggedUserFetchRequest()
        do {
            let fetchedUsers = try context.fetch(userFetchRequest)
            fetchedUsers.forEach { context.delete($0) }
            saveContext()
        } catch {
            fatalError("Failed to fetch CDLoggedUser objects")
        }
    }

    func getSearchResults() -> SearchResults? {
        let context = persistentContainer.viewContext
        let searchResultsFetchRequest = CDSearchResults.searchResultsFetchRequest()
        do {
            let fetchedSearchResults = try context.fetch(searchResultsFetchRequest)
            return fetchedSearchResults.first?.dataModel
        } catch {
            fatalError("Failed to fetch CDSearchResults objects")
        }
    }

    func saveSearchResults(_ results: SearchResults) {
        let context = persistentContainer.viewContext
        let newSearchResults = CDSearchResults.insertNewSearchResults(in: context)
        newSearchResults.query = results.query
        newSearchResults.ts = results.ts as NSDate
        for item in results.items {
            let newResultItem = CDResultItem.insertNewResultItem(in: context)
            newResultItem.title = item.title
            newResultItem.contents = item.contents
            newResultItem.ts = item.ts as NSDate
            newSearchResults.addToItems(newResultItem)
        }
        saveContext()
    }

    func deleteSearchResults() {
        let context = persistentContainer.viewContext
        let searchResultsFetchRequest = CDSearchResults.searchResultsFetchRequest()
        do {
            let fetchedSearchResults = try context.fetch(searchResultsFetchRequest)
            fetchedSearchResults.forEach { context.delete($0) }
            saveContext()
        } catch {
            fatalError("Failed to fetch CDSearchResults objects")
        }
    }

    private func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
}
