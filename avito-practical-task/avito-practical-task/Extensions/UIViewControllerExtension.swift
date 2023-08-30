//
//  UIViewControllerExtension.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 30.08.2023.
//

import UIKit

extension UIViewController {
    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert.
    ///
    /// - Parameters:
    ///   - title: title of the alert.
    ///   - message: message/body of the alert.
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this parameter is nil.
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be
    /// highlighted.
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an
    /// argument.
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    func showAlert(
        title: String?,
        message: String?,
        buttonTitles: [String]? = nil,
        highlightedButtonIndex: Int? = nil,
        completion: ((Int) -> Void)? = nil
    ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.isEmpty {
            allButtons.append("OK")
        }

        for index in 0 ..< allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                completion?(index)
            })
            alertController.addAction(action)
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
}
