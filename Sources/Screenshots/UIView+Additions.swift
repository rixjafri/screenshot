import Foundation
import UIKit

extension UIView {
    /// Return an `UIImage`with the visible contents inside the Cropping Rect
    /// - Parameter croppingRect: a rect to focus the screenshot
    /// - Returns: an `UIImage` with the visible contents inside the cropping rect
    func screenshotForCroppingRect(croppingRect: CGRect) -> UIImage? {
        // Ensure that the croppingRect has valid dimensions
        guard croppingRect.size.width > 0, croppingRect.size.height > 0 else {
            print("Invalid croppingRect size: \(croppingRect.size)")
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.translateBy(x: -croppingRect.origin.x, y: -croppingRect.origin.y)
        self.layoutIfNeeded()
        self.layer.render(in: context)

        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    /// Returns a screenshot as `UIImage` from the whole view
    @objc public var screenshot: UIImage? {
        return self.screenshotForCroppingRect(croppingRect: self.bounds)
    }
}
