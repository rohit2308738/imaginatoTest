//
//  HomeViewModel.swift
//  ImaginatoTest
//
//  Created by Rohit sandhu on 3/24/21.
//

import Foundation
import UIKit

class HomeViewModel: BaseViewModel {
    
    var Detail = UILabel()
    
   func loadData()
   {
    Detail.text = "Username = " + "\(UserDefaults.standard.value(forKey: "userName") ?? "")" + "\n Created At = " + "\(UserDefaults.standard.value(forKey: "createdDate") ?? "")"
   }
    
    
}
