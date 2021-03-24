//
//  LoginViewModel.swift
//  ImaginatoTest
//
//  Created by Rohit sandhu on 3/24/21.
//

import Foundation
import UIKit

class LoginViewModel: BaseViewModel {
    
    var email = UITextField()
    var password = UITextField()
    
    
    //MARK: Validation method to check user credentials are valid or not.
    func validation(){
       
        if email.text?.count ?? 0 <= 0 || password.text?.count ?? 0 <= 0{
            showMessage(with: "Please fill all the fields")
        }
        else if email.validateEmail(enteredEmail: email.text ?? "") == false{
            showMessage(with: "Please enter valid email")
        }
        else if email.validatePassword(password.text ?? "") == false{
            showMessage(with: "Password require at least 1 uppercase, 1 lowercase and 1 number and minimum 8 letters")
        }
        else{
            loginApi()
        }
        
        
    }
    
    
    //MARK: Login APi method to intract with server
    func loginApi(){
        showLoader()
         let prams :[String:String] = [
            "email":email.text ?? "",
            "password":password.text ?? ""]
            
        WebService.shared.login(prams: prams, self.hostViewController) { (data) in
           print(data)
           UserDefaults.standard.set(data.userId, forKey: "UserId")
           UserDefaults.standard.set(data.username, forKey: "userName")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            let date = dateFormatter.date(from:data.created_at)!
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yyyy"
            let myStringafd = formatter.string(from: date)
            UserDefaults.standard.set(myStringafd, forKey: "createdDate")
            print(myStringafd)
            HomeViewController.show(from: self.hostViewController) { (success) in
            }
           
        }
    }
    
    
}
