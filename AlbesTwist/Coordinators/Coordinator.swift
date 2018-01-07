import Cocoa

protocol Coordinator: class {
    /// Array containing child coordinators
    var childCoordinators: [Coordinator] { get set }
    /// Start this coordinator
    func start()
}

fileprivate enum CoordinatorConstants {
    static let mainStoryName = NSStoryboard.Name("Main")
}

extension Coordinator {
    /// Add `coordinator` to `childCoordinators` array
    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    /// Remove `coordinator` from `childCoordinators` array
    func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    /// Returns a reference to the main storyboard in the app
    func getMainStoryboard() -> NSStoryboard {
        return NSStoryboard(name: CoordinatorConstants.mainStoryName, bundle: nil)
    }
}
