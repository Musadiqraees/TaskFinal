//
//  LoginViewModel.swift
//  TASK2
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation


protocol LoginEventsDelegate {
    
    func loginViewModel_LoginCallFinished(jsonData : JSON, errMsg : Error?)
}

class LoginViewModel
{
    var delegate : LoginEventsDelegate?
    var username: String?
    var password: String?
    
    init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
    }
    
    func LoginUser(userName: String,Pasword: String) -> ()
    {
        WebService().Login(username:userName,password:Pasword){ (json, error)  in
       if let accessToken =  json["access_token"].string
        {
          SharedManager .sharedInstance .setApiToken(token:"Bearer \(accessToken)");
            }
        self.delegate?.loginViewModel_LoginCallFinished(jsonData : json , errMsg : error)
        
        }
    }
    
    
    
    
}
