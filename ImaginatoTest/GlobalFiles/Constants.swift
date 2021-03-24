//
//  Constants.swift
//  ImaginatoTest
//
//  Created by Rohit sandhu on 3/24/21.
//

import Foundation
import UIKit

struct ViewControllerIdentifier {
}


extension UIStoryboard {
    class var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension ViewControllerIdentifier {
    static let login                             = "LoginViewController"
    static let home                             = "HomeViewController"
}

extension UIViewController {
    
    func endEditing(_ force: Bool) {
        self.view.endEditing(force)
    }
}

extension UITextField{
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    func validatePassword(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
        return passwordTest.evaluate(with: password)
    }

}
