//
//  SharedManager.swift
//  TASK2
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import CoreLocation


extension UIViewController {
    
    func alert(message: String, title: String = "Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


class SharedManager {
    static let sharedInstance = SharedManager()
    private init() {}
    var locationManager = CLLocationCoordinate2D()
    
    func setApiToken(token:String) -> ()
    {
     UserDefaults.standard.setValue(token, forKey: "user_auth_token")
    }
    
    func getApiToken() -> (String) {
        let token =   UserDefaults.standard.value(forKey: "user_auth_token") as! String
        return token
    }
    
    func setLocation(location: CLLocationCoordinate2D) -> ()
    {
        self.locationManager = location
    }
    
    func getLocation() -> (CLLocationCoordinate2D)
    {
        return self.locationManager
    }
    
    
}
   
