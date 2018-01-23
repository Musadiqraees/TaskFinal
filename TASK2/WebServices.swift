//
//  WebServices.swift
//  TASK2
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import Alamofire
 


private var Baseurl = URL(string: "https://api.uvita.eu/")!

typealias JSONDictionary = [String:Any]

class WebService:NSObject
{
    typealias serviceResponce = (JSON ,Error?) ->()
    
    func Login(username:String,password:String,onCompletion:@escaping serviceResponce) -> () {
        let SecretKey = String("aXBob25lOmlwaG9uZXdpbGxub3RiZXRoZXJlYW55bW9yZQ==")
        // create the request
        let Endpoint = "\(Baseurl)/oauth/token?grant_type=password&username=\(username)&password=\(password)"
        
        let headers = [
            
            "Accept" : "application/json",
            "Authorization" : "Basic \(SecretKey)",
            "Content-Type" : "application/x-www-form-urlencoded" ,
            ]
        
        
        Alamofire.request(Endpoint, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil
                    {
                        print(response.result.value ?? "sfsdfsd")
                        let json:JSON = JSON(response.result.value ?? "")
                        onCompletion(json,response.result.error)
                        }
                    break
                    case .failure(_):
                    print(response.result.error ?? "sdfsdfsf")
                    
                    onCompletion(nil,response.result.error)
                    break
                    
                }
        }
        
    }
    
    
    func getDoctor(parameters:JSONDictionary,onCompletion:@escaping serviceResponce)->()
    {
        let searchText:String? = parameters["searchText"] as? String
        let LastKey:String? = parameters["LastKey"] as? String
        let location  = SharedManager.sharedInstance.getLocation()
        
        //searchText:String?,LastKey:String?
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.uvita.eu"
        urlComponents.path = "/api/users/me/doctors"
        
       // 'https://api.uvita.eu/api/users/me/doctors?search=Fritzhof&lat=52.534709&lng=
       // 13.3976972'
        
        let dateQuery = URLQueryItem(name: "search", value: (searchText))
        let conceptQuery = URLQueryItem(name: "lat", value: (location.latitude.description))
        
        let hdQuery = URLQueryItem(name: "lng", value: location.longitude.description)
        let apiKeyQuery = URLQueryItem(name: "lastKey", value: LastKey)
        
        urlComponents.queryItems = [dateQuery, conceptQuery, hdQuery ]
        if (LastKey != "")
        {
        urlComponents.queryItems?.append(apiKeyQuery)
        }
        
        // create the request
       // let Endpoint1 = "\(Baseurl)api/users/me/doctors?search=\(searchText)&lat=52.534709&lng=13.3976972"
        
        let Endpoint = (urlComponents.url)
        let headers = [
            "Accept" : "application/json",
            "Authorization" : "\(SharedManager.sharedInstance.getApiToken())",
            "Content-Type" : "application/x-www-form-urlencoded" ,
            ]
        
        Alamofire.request(Endpoint!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil
                    {
                        print(response.result.value ?? "")
                        
                        let json:JSON = JSON(response.result.value ?? "")
                        
                        onCompletion(json,response.result.error)
                    }
                    break
                    case .failure(_):
                    print(response.result.error ?? "")
                    onCompletion(nil,response.result.error)
                    break
                    
                }
        }
        
    }
    
   
}
