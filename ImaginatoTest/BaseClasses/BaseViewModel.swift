//
//  BaseViewModel.swift
//  ShowToStream
//
//  Created by Applify on 15/12/20.
//  Copyright © 2020 Applify. All rights reserved.
//


import SwiftMessages
import UIKit

class BaseViewModel: NSObject {
    weak var hostViewController: BaseViewController!
    
    init(hostViewController: BaseViewController) {
        super.init()
        self.hostViewController = hostViewController
    }
}


extension BaseViewModel {
    @objc
    func viewLoaded() {
        
    }
}

// MARK: - Error Handling
extension BaseViewModel {
    
    func hasErrorIn(_ response: [String: Any]?,
                    showError: Bool = true) -> Bool {
        return BaseViewModel.hasErrorIn(response,
                                        showError: showError,
                                        hostViewController: self.hostViewController)
    }
    
    class func hasErrorIn(_ response: [String: Any]?,
                          showError: Bool = true,
                          hostViewController: BaseViewController? = nil) -> Bool {
        guard let response = response,
            let code = response[APIConstants.code],
            let message = response[APIConstants.message] as? String else {
                if showError {
                    showMessage(with: GenericErrorMessages.internalServerError)
                }
                return true
        }
        
        if "\(code)" != "200" {
            if showError {
                showMessage(with: message)
            }
            if "\(code)" == "401" { // invalid access token. should go to welcome / login screen
//                UserModel.shared.logoutUser()
//                hostViewController?.gotoWelcomeScreen()
            }
            return true
        }
        return false
    }
}


