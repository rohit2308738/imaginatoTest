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
            "content-type": "application/json"]

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
    
    
 }
