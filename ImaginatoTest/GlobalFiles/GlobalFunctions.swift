//
//  GlobalFUntions.swift
//  ImaginatoTest
//
//  Created by Rohit sandhu on 3/24/21.
//

import Foundation
import SwiftMessages
import SVProgressHUD


func showLoader() {
    SVProgressHUD.show()
}

/// Hides the loader
func hideLoader() {
    SVProgressHUD.dismiss()
}

func delay(_ seconds: Double, f: @escaping () -> Void) {
    let delay = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delay) {
        f()
    }
}

func showMessage(with title: String, theme: Theme = .error) {
    SwiftMessages.show {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(theme)
        view.configureContent(title: title , body: title, iconImage: Icon.info.image)
        view.button?.isHidden = true
        view.bodyLabel?.font = UIFont (name: "Helvetica Neue", size: 15)
        view.titleLabel?.isHidden = true
        view.iconLabel?.isHidden = true
        return view
    }
}
func showSuccessMessage(with title: String, theme: Theme = .success) {
    SwiftMessages.show {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(theme)
        view.configureContent(title: title , body: title, iconImage: Icon.info.image)
        view.button?.isHidden = true
        view.bodyLabel?.font = UIFont (name: "Helvetica Neue", size: 15)
        view.titleLabel?.isHidden = true
        view.iconLabel?.isHidden = true
        return view
    }
}
