//
//  LoginViewController.swift
//  ImaginatoTest
//
//  Created by Rohit sandhu on 3/24/21.
//

import UIKit

class LoginViewController: BaseViewController {

    override class func storyboard() -> UIStoryboard {
        return UIStoryboard.main
    }
    
    override class func identifier() -> String {
        return ViewControllerIdentifier.login
    }
    
    override func getViewModel() -> BaseViewModel {
        return viewModel
    }
    lazy var viewModel = LoginViewModel(hostViewController: self)
    
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.value(forKey: "UserId") as? String != nil{
            HomeViewController.show(from: self.viewModel.hostViewController) { (success) in
            }
        }
        
        self.viewModel.email = emailTextField
        self.viewModel.password = passwordTextField
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        self.viewModel.validation()
     }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
