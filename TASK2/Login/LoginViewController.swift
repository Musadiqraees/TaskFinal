//
//  ViewController.swift
//  TASK2
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController ,LoginEventsDelegate{
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    private var LoginViewModelObj : LoginViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.LoginViewModelObj = LoginViewModel()
        self.LoginViewModelObj.delegate=self
        self.userNameTextField.text = "ioschallenge@uvita.eu"
        self.passwordTextField.text = "shouldnotbetoohard"
        }
    


    @IBAction func loginButtonPressed(_ sender: Any)
    {
    guard self.userNameTextField.text != nil else
        {
            self.alert(message: "Please enter User")
            return
        }
    guard self.passwordTextField.text != nil else
        {
            self.alert(message: "Please enter password")
            return
        }
    LoginViewModelObj.LoginUser(userName: self.userNameTextField.text!, Pasword: self.passwordTextField.text!)
    MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    
    ////////delegate method
    func loginViewModel_LoginCallFinished(jsonData : JSON, errMsg : Error?)
    {
        MBProgressHUD.hide(for: self.view, animated: true)
        ///////// interaction with ui is done in VC
        if errMsg != nil
        {
            self.alert(message: "Not a valid request")
        }
        else if jsonData["error"].string != nil
        {
         self.alert(message: "You are not Authorized")
        }
        else if jsonData["access_token"].string != nil
        {
            performSegue(withIdentifier: "LoginToDoctor", sender: nil)
        }
        
        
        
    

}

}
