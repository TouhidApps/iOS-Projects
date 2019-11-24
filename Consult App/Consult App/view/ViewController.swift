//
//  ViewController.swift
//  Consult App
//
//  Created by Touhid on 7/11/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ViewController: UIViewController, UITextFieldDelegate {

    let myX = 30
    let myY = 100
    
    var tfName  = UITextField()
    var tfPhone = UITextField()
    var tfEmail = UITextField()
    
    var textFieldName   = SkyFloatingLabelTextFieldWithIcon()
    var textFieldPhone  = SkyFloatingLabelTextFieldWithIcon()
    var textFieldEmail  = SkyFloatingLabelTextFieldWithIcon()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: myX, y: myY, width: Int(self.view.bounds.width - 60), height: 45), iconType: .image)
        textFieldName.placeholder   = "Full name"
        textFieldName.title         = "Full name"
        textFieldName.delegate      = self
        textFieldName.iconImage     = UIImage(imageLiteralResourceName: "profile")
        tfName                      = textFieldName
        self.view.addSubview(makeDesign(floatingLabel: textFieldName))
        
        textFieldPhone = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: myX, y: myY + 50, width: Int(self.view.bounds.width - 60), height: 45), iconType: .image)
        textFieldPhone.placeholder  = "+8801"
        textFieldPhone.title        = "Phone No"
        textFieldPhone.delegate     = self
        textFieldPhone.iconImage    = UIImage(imageLiteralResourceName: "phone")
        tfPhone                     = textFieldPhone
        self.view.addSubview(makeDesign(floatingLabel: textFieldPhone))
        
        textFieldEmail = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: myX, y: myY + 100, width: Int(self.view.bounds.width - 60), height: 45), iconType: .image)
        textFieldEmail.placeholder  = "example@domain.com"
        textFieldEmail.title        = "Email"
        textFieldEmail.delegate     = self
        textFieldEmail.iconImage    = UIImage(imageLiteralResourceName: "email")
        tfEmail                     = textFieldEmail
        self.view.addSubview(makeDesign(floatingLabel: textFieldEmail))
        
        let submitButton = UIButton(frame: CGRect(x: myX, y: myY + 170, width: Int(self.view.bounds.width - 60), height: 45))
        submitButton.setTitle("Login", for: UIControlState.normal)
        submitButton.backgroundColor    = #colorLiteral(red: 0.1811446828, green: 0.5273533276, blue: 0.6751333576, alpha: 1)
        submitButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        submitButton.addTarget(target, action: #selector(loginOperation), for: UIControlEvents.touchUpInside)
        submitButton.layer.cornerRadius = 15
        self.view.addSubview(submitButton)
        
      
        
    } // END of viewDidLoad
    
    // Keyboard return button event 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case textFieldName:
                
                textFieldPhone.becomeFirstResponder()
                
                break
            
        case textFieldPhone:
                
                textFieldEmail.becomeFirstResponder()
                
                break
            
        case textFieldEmail:
                
                textFieldEmail.resignFirstResponder()
                
                break
            
            default:
                NSLog("Default", "")
            
        }
        return false
    }
 
    
    @objc func loginOperation(){
        
        if let name = tfName.text,
            let phone = tfPhone.text,
            let email = tfEmail.text {
            if name.isEmpty || phone.isEmpty || email.isEmpty {return}
            makeLoginRequest(name: name, phone: phone, email: email)
        } else {
            
        }
        
    }
    
   

    func makeDesign(floatingLabel: SkyFloatingLabelTextFieldWithIcon) -> SkyFloatingLabelTextFieldWithIcon {
        floatingLabel.tintColor             = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1) // the color of the blinking cursor
        floatingLabel.textColor             = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        floatingLabel.lineColor             = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        floatingLabel.selectedTitleColor    = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        floatingLabel.selectedLineColor     = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        floatingLabel.titleColor            = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        floatingLabel.placeholderColor      = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5074111729)
        floatingLabel.lineHeight            = 1.0 // bottom line height in points
        floatingLabel.selectedLineHeight    = 2.0
        return floatingLabel
    }
    
 
    
    
    func makeLoginRequest(name: String, phone: String, email: String) {
        
        let url                     = String(format: MyConstants.API_POST_USER)
        let parameterDictionary     = ["name" : name, "phone" : phone, "email" : email]
        var request                 = URLRequest(url: URL(string: url)!)
        request.httpMethod          = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    let res = json["result"] as! String
                    print(res)
                    
                    if res.elementsEqual("Success") {
                        // save user info, in future update values will come from server
                        UserDefaults.standard.set(name  , forKey: MyConstants.USER_LOGIN_NAME   )
                        UserDefaults.standard.set(phone , forKey: MyConstants.USER_LOGIN_PHONE  )
                        UserDefaults.standard.set(email , forKey: MyConstants.USER_LOGIN_EMAIL  )

                        self.dismiss(animated: true, completion: nil)
                    }
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }

    
    
    

}












