//
//  LoaderOverlayable.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import UIKit

protocol LoaderOverlayable {
    var loadingOverlay: UIAlertController? { get set }
    mutating func showLoadingOverlay()
    func hideLoadingOverlay()
}

extension LoaderOverlayable where Self: UIViewController {
    
    mutating func showLoadingOverlay() {
        loadingOverlay = UIAlertController(
            title: nil,
            message: "Loading...",
            preferredStyle: .alert
        )

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        loadingOverlay!.view.addSubview(loadingIndicator)
        self.present(loadingOverlay!, animated: true, completion: nil)
    }
    
    func hideLoadingOverlay() {
        loadingOverlay?.dismiss(animated: true)
    }
    
}
