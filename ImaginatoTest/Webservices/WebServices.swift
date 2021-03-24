//
//  WebServices.swift
//  YoutubeSwift
//
//  Created by Gurinder Singh Batth on 19/06/17.
//  Copyright © 2017 Batth. All rights reserved.
//

import UIKit

extension UIViewController :URLSessionDelegate{
    
    func webservicesPostRequest(baseString: String, parameters: [String:Any],success:@escaping (_ response: NSDictionary)-> Void, failure:@escaping (_ error: Error) -> Void){
        
        let headers = [
            "content-type": "application/json",
            "auth_key":"7#,?p8L4I{OOAK`zmZM(8KE#v|daX;]NeEFTVzP=y!*S[qrFDM(tX2|!6)R5MeCA"]

        let sessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let jsonData = try? JSONSerialization.data(withJSONObject:parameters)
        
        let url = baseString
        
        print(url)
        print(parameters)
        
        var request = URLRequest(url: URL(string: url)!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
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
    
    
    func webServiceGetRequest(baseString: String, parameters: [String:String]?, success:@escaping (_ response: NSDictionary) ->Void, failure:@escaping (_ error: Error) -> Void){
        
        let headers = [
                       "content-type": "application/json",
                       "auth_key":"7#,?p8L4I{OOAK`zmZM(8KE#v|daX;]NeEFTVzP=y!*S[qrFDM(tX2|!6)R5MeCA"
           ]
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        guard let url = URL(string: baseString) else{
            
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.allHTTPHeaderFields = parameters
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                if let responseData = data{
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                        success(json as? NSDictionary ??  NSDictionary())
                    }catch let err{
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
    
    func webServicePutRequestLogout(baseString: String, parameters: [String:String]?, success:@escaping (_ response: Any) ->Void, failure:@escaping (_ error: Error) -> Void){
        
        let headers = [
                       "auth_key":"7#,?p8L4I{OOAK`zmZM(8KE#v|daX;]NeEFTVzP=y!*S[qrFDM(tX2|!6)R5MeCA"
           ]
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        guard let url = URL(string: baseString) else{
            
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.allHTTPHeaderFields = parameters
        request.httpMethod = "PUT"
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                if let responseData = data{
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                        success(json as? NSDictionary ??  NSDictionary())
                    }catch let err{
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
    
    func uploadGalleryImages(urlString:String,params:[String:String]?,image:UIImage?,success:@escaping (_ response: NSDictionary)-> Void, failure:@escaping (_ error: Error) -> Void){
         
         let boundary: String = "------VohpleBoundary4QuqLuM1cE5lMwCy"
         let contentType: String = "multipart/form-data; boundary=\(boundary)"
        let headers = [
                       "content-type": contentType,
                       "auth_key":"7#,?p8L4I{OOAK`zmZM(8KE#v|daX;]NeEFTVzP=y!*S[qrFDM(tX2|!6)R5MeCA"
           ]

         var request = URLRequest(url: URL(string: urlString)!)
         
         for (key, value) in headers {
             request.setValue(value, forHTTPHeaderField: key)
         }
         
         request.httpShouldHandleCookies = false
         request.timeoutInterval = 60
         request.httpMethod = "POST"
         request.setValue(contentType, forHTTPHeaderField: "Content-Type")
     
     

     
         let body = NSMutableData()
         if let parameters = params {
             for (key, value) in parameters {
                 body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                 body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                 body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
             }
         }
         //which field you have to sent image on server
         let fileName: String = "image_file"
         if image != nil {
             body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
             body.append("Content-Disposition: form-data; name=\"\(fileName)\"; filename=\"image\(arc4random()).png\"\r\n".data(using: String.Encoding.utf8)!)
             body.append("Content-Type:image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
             body.append((image?.jpegData(compressionQuality: 0.5))!)
             body.append("\r\n".data(using: String.Encoding.utf8)!)
         }
         body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
         request.httpBody = body as Data
         let session = URLSession(configuration:.default, delegate: self, delegateQueue: .main)
         let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
             DispatchQueue.main.async {
                 if(error != nil){
                     //  print(String(data: data!, encoding: .utf8) ?? "No response from server")
                     failure(error!)
                 }
                 if let responseData = data{
                     do {
                         let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                         success(json as! NSDictionary)
                     }catch let err{
                         
                         failure(err)
                         
                     }
                 }
             }
         }
         task.resume()
     }
    
    
    
    func saveData(location:URL,downloadURL:String){
        
        
        do {
            let downloadedData = try Data(contentsOf: location)
            
            DispatchQueue.main.async(execute: {
                print("transfer completion OK!")
                
                let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
                let destinationPath = documentDirectoryPath.appendingPathComponent(downloadURL)
                
                let pdfFileURL = URL(fileURLWithPath: destinationPath)
                FileManager.default.createFile(atPath: pdfFileURL.path,
                                               contents: downloadedData,                                               attributes: nil)
                
                if FileManager.default.fileExists(atPath: pdfFileURL.path) {
                    print("pdfFileURL present!") // Confirm that the file is here!
                }
            })
        } catch {
            print(error.localizedDescription)
        }
        
        
        
    }
}
