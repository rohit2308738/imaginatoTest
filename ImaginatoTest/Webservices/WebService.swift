//
//  WebService.swift
//  DatingApp
//
//  Created by Manvir singh on 07/10/18.
//  Copyright © 2018 SIERRA. All rights reserved.
//

import UIKit

class WebService: UIViewController {

   
   static let shared = WebService()
   
   //MARK: Login APi method to intract with server
    
   func login(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: LoginUser)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.login, parameters: prams, success: { (res) in
            
            if "0" == "\(res.value(forKey: "result") ?? "0")" {
                showMessage(with: "\(res.value(forKey: "error_message") ?? "No Result")")
                hideLoader()
                return
            }
            if let dicData = res.value(forKeyPath: "data.user") as? NSDictionary {
                let registerData = LoginUser(created_at: "\(dicData.value(forKey: "created_at") ?? "")",
                                             userId: "\(dicData.value(forKey: "userId") ?? "")",
                                             username: "\(dicData.value(forKey: "userName") ?? "")")
                success(registerData)
            }
        }) { (err) in
         
            showMessage(with: "Invalid username or Password")
        }
    }
    
   
    
}
