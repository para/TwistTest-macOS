import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var mainCoordinator: MainCoordinator?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainCoordinator = MainCoordinator()
        mainCoordinator?.start()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}
