//
//  HomeViewController.swift
//  ImaginatoTest
//
//  Created by Rohit sandhu on 3/24/21.
//

import UIKit

class HomeViewController: BaseViewController {

    override class func storyboard() -> UIStoryboard {
        return UIStoryboard.main
    }
    
    override class func identifier() -> String {
        return ViewControllerIdentifier.home
    }
    
    override func getViewModel() -> BaseViewModel {
        return viewModel
    }
    
    @IBOutlet var detailsLabel: UILabel!
    lazy var viewModel = HomeViewModel(hostViewController: self)
    
    class func show(from viewController: UIViewController,
                    forcePresent: Bool = false,
                    completionHandler: @escaping (Bool) -> Void) {
        let controller = self.getController() as! HomeViewController
        controller.modalPresentationStyle = .fullScreen
        controller.show(from: viewController, forcePresent: forcePresent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.Detail = detailsLabel
        self.viewModel.loadData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logourAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "UserId")
        self.navigationController?.popViewController(animated: true)
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
