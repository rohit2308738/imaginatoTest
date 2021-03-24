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
    
    
    
   
}


