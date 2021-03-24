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
   
   private func webservicesPutRequest(baseString: String, parameters: [String:String],success:@escaping (_ response: NSDictionary)-> Void, failure:@escaping (_ error: Error) -> Void){
    
        let headers = [
                       "auth_key":"7#,?p8L4I{OOAK`zmZM(8KE#v|daX;]NeEFTVzP=y!*S[qrFDM(tX2|!6)R5MeCA"
           ]
    
        let sessionConfiguration = URLSessionConfiguration.default
    
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
    
        let jsonData = try? JSONSerialization.data(withJSONObject:parameters)
    
        let url = baseString
    
        print(url)
        print(parameters)
    
        var request = URLRequest(url: URL(string: url)!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "PUT"
        request.httpBody = jsonData
    
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                if let responseData = data{
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                        success(json as? NSDictionary ?? NSDictionary())
                    }
                    catch let err
                    {
                        print(err)
                        failure(err)
                        
                    }
                }
            }else{
                failure(error!)
            }
        }
        dataTask.resume()
    }
    
    func register(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Register)-> Void){
        
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.signUp, parameters: prams, success: { (res) in
            
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                showMessage(with: "\(res.value(forKey: "message") ?? "0")")
                hideLoader()
                return
            }
            
            if let dicData = res.value(forKey: "data") as? NSDictionary {
                
                let registerData = Register(id: "\(dicData.value(forKey: "id") ?? "")",
                                            name: "\(dicData.value(forKey: "name") ?? "")",
                                            email: "\(dicData.value(forKey: "email") ?? "")",
                                            device_type: "\(dicData.value(forKey: "device_type") ?? "")",
                                            image: "\(dicData.value(forKey: "image") ?? "")")
                success(registerData)
            }
        }) { (err) in
        }
    }
    
    func login(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Register)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.login, parameters: prams, success: { (res) in
            
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                showMessage(with: "\(res.value(forKey: "message") ?? "0")")
                hideLoader()
                return
            }
            if let dicData = res.value(forKey: "data") as? NSDictionary {
                let registerData = Register(id: "\(dicData.value(forKey: "id") ?? "")",
                                            name: "\(dicData.value(forKey: "name") ?? "")",
                                            email: "\(dicData.value(forKey: "email") ?? "")",
                                            device_type: "\(dicData.value(forKey: "device_type") ?? "")",
                                            image: "\(dicData.value(forKey: "image") ?? "")")
                success(registerData)
            }
        }) { (err) in
         
        }
    }
    
    func resetPassword(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Register)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.resetPassword, parameters: prams, success: { (res) in
            
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                showMessage(with: "\(res.value(forKey: "message") ?? "0")")
                hideLoader()
                return
            }
            if let dicData = res.value(forKey: "data") as? NSDictionary {
                let registerData = Register(id: "\(dicData.value(forKey: "id") ?? "")",
                                            name: "\(dicData.value(forKey: "name") ?? "")",
                                            email: "\(dicData.value(forKey: "email") ?? "")",
                                            device_type: "\(dicData.value(forKey: "device_type") ?? "")",
                                            image: "\(dicData.value(forKey: "image") ?? "")")
                success(registerData)
            }
        }) { (err) in
         
        }
    }
    
    
    func forgotPassword(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSNumber)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.forgotPassword, parameters: prams, success: { (res) in
             hideLoader()
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                showMessage(with: "\(res.value(forKey: "message") ?? "0")")
                return
            }
            if let dicData = res.value(forKey: "otp") as? NSNumber {
              success(dicData)
                
            }
        }) { (err) in
         
        }
    }
    
    
    func fetchAddApi(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: NSArray)-> Void){
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.screenAdds, parameters: prams, success: { (res) in
            print(res)
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                showMessage(with: "\(res.value(forKey: "message") ?? "0")")
                hideLoader()
                return
            }
            if let arr = res.value(forKey: "data") as? NSArray {
                success(arr)
            }
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getStoresApi(_ vc:UIViewController, success:@escaping (_ response: NSArray)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getStores, parameters: [:]) { (res) in
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                showMessage(with: "\(res.value(forKey: "message") ?? "0")")
                hideLoader()
                return
            }
            if let arr = res.value(forKey: "data") as? NSArray {
                success(arr)
            }
        } failure: { (error) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getStoreDetail(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: NSDictionary)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getStoreDetails, parameters: prams) { (res) in
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                hideLoader()
                showMessage(with: "\(res.value(forKey: "message") ?? "0")")
                return
            }
            if let arr = res.value(forKey: "data") as? NSDictionary {
                success(arr)
            }
        } failure: { (error) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func prescriptionDetailApi(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: NSDictionary)-> Void){
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.prescriptionDetail, parameters: prams, success: { (res) in
            print(res)
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                hideLoader()
                showMessage(with: "\(res.value(forKey: "message") ?? "false")")
                return
            }
            if let arr = res.value(forKey: "data") as? NSDictionary {
                success(arr)
            }
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getCoupenApi(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: NSArray)-> Void){
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getCoupons, parameters: prams, success: { (res) in
            print(res)
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                hideLoader()
                showMessage(with: "\(res.value(forKey: "message") ?? "false")")
                return
            }
            if let arr = res.value(forKey: "coupons") as? NSArray {
                success(arr)
            }
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func detetePrescriptionApi(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: Bool)-> Void){
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.deletePrescription, parameters: prams, success: { (res) in
            print(res)
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                hideLoader()
                showMessage(with: "\(res.value(forKey: "message") ?? "false")")
                return
            }
            else{
                success(true)
            }
            
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    func refillPrescriptionApi(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: Bool)-> Void){
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.refillPrescription, parameters: prams, success: { (res) in
            print(res)
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                hideLoader()
                showMessage(with: "\(res.value(forKey: "message") ?? "false")")
                return
            }
            else{
                success(true)
            }
            
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    
    
    func get_subcat_storesApi(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: NSArray)-> Void){
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getsubcatstores, parameters: prams, success: { (res) in
            print(res)
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                hideLoader()
                showMessage(with: "\(res.value(forKey: "message") ?? "false")")
                return
            }
            if let arr = res.value(forKey: "data") as? NSArray {
                success(arr)
            }
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func getPrescriptionListApi(prams:[String:String],_ vc:UIViewController, success:@escaping (_ response: NSArray)-> Void){
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getPrescriptionList, parameters: prams, success: { (res) in
            print(res)
            if "0" == "\(res.value(forKey: "status") ?? "0")" {
                hideLoader()
                showMessage(with: "\(res.value(forKey: "message") ?? "false")")
                return
            }
            if let arr = res.value(forKey: "data") as? NSArray {
                success(arr)
            }
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func uploadGalleryFile(prams:[String:String],image:UIImage,_ vc:UIViewController,success:@escaping (_ response: Bool)-> Void){
        
        uploadGalleryImages(urlString: Constants.baseUrl + Constants.uploadPrescription, params: prams, image: image, success: { (res) in
            success(true)
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
        
        
    }
    
    func Sociallogin(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Register)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.socialLogin, parameters: prams, success: { (response) in
            
            if let dicData = response.value(forKey: "data") as? NSDictionary {
                let registerData = Register(id: "\(dicData.value(forKey: "id") ?? "")",
                                            name: "\(dicData.value(forKey: "name") ?? "")",
                                            email: "\(dicData.value(forKey: "email") ?? "")",
                                            device_type: "\(dicData.value(forKey: "device_type") ?? "")",
                                            image: "\(dicData.value(forKey: "image") ?? "")")
                success(registerData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getCategoryList(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSArray)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getCategory, parameters: prams, success: { (response) in
            
            if let dicData = response.value(forKey: "Categories") as? NSArray {
               success(dicData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getProductList(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSArray)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.searchProducts, parameters: prams, success: { (response) in
            if "false" == "\(response.value(forKey: "status") ?? "false")" {
                let category = NSArray()
                //showMessage(with: "\(response.value(forKey: "message") ?? "0")")
                success(category)
            }
            if let dicData = response.value(forKey: "productArray") as? NSArray {
               success(dicData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getProductDetail(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSDictionary)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.productDetail, parameters: prams, success: { (response) in
            if let dicData = response.value(forKey: "product") as? NSDictionary {
               success(dicData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func getCart(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSArray)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getCart, parameters: prams, success: { (response) in
            if let dicData = response.value(forKey: "cartArray") as? NSArray {
               success(dicData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func addToCart(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Bool)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.addToCart, parameters: prams, success: { (response) in
            
            if "true" == "\(response.value(forKey: "status") ?? "false")" {
               success(true)
            }else{
                showMessage(with: "\(response.value(forKey: "message") ?? "")")
            }
            
            
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func deleteItemFromCart(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Bool)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.deleteItem, parameters: prams, success: { (response) in
            
            if "true" == "\(response.value(forKey: "status") ?? "false")" {
               success(true)
            }else{
                showMessage(with: "\(response.value(forKey: "message") ?? "")")
            }
            
            
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func addAddress(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Bool)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.addAddress, parameters: prams, success: { (response) in
            hideLoader()
            if "true" == "\(response.value(forKey: "status") ?? "false")" {
               success(true)
            }else{
                showMessage(with: "\(response.value(forKey: "message") ?? "")")
            }
            
            
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func placeOrderApi(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Bool)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.placeOrder, parameters: prams, success: { (response) in
            hideLoader()
            if "true" == "\(response.value(forKey: "status") ?? "false")" {
               success(true)
            }else{
                showMessage(with: "\(response.value(forKey: "message") ?? "")")
            }
            
            
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func orderPrescriptionApi(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Bool)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.orderPrescription, parameters: prams, success: { (response) in
            hideLoader()
            if "true" == "\(response.value(forKey: "status") ?? "false")" {
               success(true)
            }else{
                showMessage(with: "\(response.value(forKey: "message") ?? "")")
            }
            
            
        }) { (err) in
            hideLoader()
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func similarProduct(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSArray)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.similarProducts, parameters: prams, success: { (response) in
            if let dicData = response.value(forKey: "similarArr") as? NSArray {
               success(dicData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getCategory(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSArray)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getCategories, parameters: prams, success: { (response) in
            if let dicData = response.value(forKey: "Categories") as? NSArray {
               success(dicData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    
    func updateCart(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: Bool)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.updateCart, parameters: prams, success: { (response) in
            if "true" == "\(response.value(forKey: "status") ?? "false")" {
               success(true)
            }else{
                showMessage(with: "\(response.value(forKey: "message") ?? "")")
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
    func getAddresses(prams:[String:String],_ vc:UIViewController,success:@escaping (_ response: NSArray)-> Void){
        
        webservicesPostRequest(baseString: Constants.baseUrl + Constants.getAddress, parameters: prams, success: { (response) in
            if let dicData = response.value(forKey: "cartArray") as? NSArray {
               success(dicData)
            }
        }) { (err) in
            showMessage(with: AUTHFAILED)
        }
    }
    
}
