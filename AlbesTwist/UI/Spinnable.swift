import Cocoa

protocol Spinnable: class {
    var spinner: NSProgressIndicator! { get }
    func startSpinning()
    func stopSpinning()
}

extension Spinnable {
    func startSpinning() {
        DispatchQueue.main.async {
            self.spinner.isHidden = false
            self.spinner.startAnimation(self)
        }
    }

    func stopSpinning() {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
            self.spinner.stopAnimation(self)
        }
    }
}
