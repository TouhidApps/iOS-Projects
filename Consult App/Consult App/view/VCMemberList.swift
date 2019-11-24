//
//  VCMemberList.swift
//  Consult App
//
//  Created by Touhid on 7/24/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit
import MessageUI

class VCMemberList: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        NSLog("SMS finish", "")
    }
    
    
    @IBOutlet weak var tableViewUserList: UITableView!
    
    
    var userModel = [Result]()
    
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Logout Alert!", message: "Do you want to logout?", preferredStyle: .alert)
        let noBtn = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        let yesBtn = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { (action) in
            
            UserDefaults.standard.removeObject(forKey: MyConstants.USER_LOGIN_EMAIL)
            UserDefaults.standard.removeObject(forKey: MyConstants.USER_LOGIN_NAME)
            UserDefaults.standard.removeObject(forKey: MyConstants.USER_LOGIN_PHONE)
            
            self.checkLogin()
            
        }
        
        alertController.addAction(noBtn)
        alertController.addAction(yesBtn)
        
        self.present(alertController, animated: true, completion: nil)

        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

       checkLogin()
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func checkLogin(){
        let email  = UserDefaults.standard.string(forKey: MyConstants.USER_LOGIN_EMAIL)
        if email == nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(vc, animated:false, completion:nil)
            
        } else {
            MyConstants.USER_EMAIL_TEMP = email!
            loadData()
        }
    }
    
    func loadData() {
        let email  = UserDefaults.standard.string(forKey: MyConstants.USER_LOGIN_EMAIL)
        guard let em = email else { return }
        let link = "\(MyConstants.API_GET_USER_LIST)\(em)"
        let url = URL(string: link)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if data == nil{ return }
            do {
                let responseModel = try jsonDecoder.decode(UserModel.self, from: data!)
                self.userModel.removeAll()
                for mValue in responseModel.result!{
                    self.userModel.append(mValue)
                }
                DispatchQueue.main.async {
                    self.tableViewUserList.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}



extension VCMemberList: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellMemberList", for: indexPath) as! TableViewCellMemberList
        let mData = self.userModel[indexPath.row]
        mCell.setDataToView(profilePicUrl: "", name: mData.name!, phone: mData.phone!, email: mData.email!)
        
        return mCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionCall = UIAlertAction(title: "Call", style: .default) { (alertAction) in
            if let phoneNo = self.userModel[indexPath.row].phone {
                self.makeCall(phoneNo: phoneNo)
            }
        }
        
        let actionSms = UIAlertAction(title: "SMS", style: .default) { (alertAction) in
            if let phoneNo = self.userModel[indexPath.row].phone {
                self.makeSms(phoneNo: phoneNo)
            }
        }
        
        let actionEmail = UIAlertAction(title: "Email", style: .default) { (alertAction) in
            if let mEmail = self.userModel[indexPath.row].email{
                self.makeEmail(email: mEmail)
            }
        }
        
        let actionChat = UIAlertAction(title: "Chat", style: .default) { (alertAction) in
            if let userName = self.userModel[indexPath.row].name, let mEmail = self.userModel[indexPath.row].email{
                self.openChat(userName: userName, email: mEmail)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            NSLog("Cancel", "")
        }
       
        let image = UIImage(named: "sms")
        let imageView = UIImageView()
        imageView.image = image
       // imageView.frame =  CGRect(x: 20, y: 100, width: 24, height: 24)
        alert.view.addSubview(imageView)

        alert.view.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        alert.addAction(actionCall)
        alert.addAction(actionSms)
        alert.addAction(actionEmail)
        alert.addAction(actionChat)
        alert.addAction(actionCancel)
        
        self.present(alert, animated: true, completion: nil)

    }
    
}

extension VCMemberList {
    
    // call
    func makeCall(phoneNo: String) {
        let url: NSURL = URL(string: "TEL://\(phoneNo)")! as NSURL
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    // sms
    func makeSms(phoneNo: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [phoneNo]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // email
    func makeEmail(email: String) {
        if !MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([email])
            composeVC.setSubject("Hello,")
            composeVC.setMessageBody("Dear concern, ", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    // start chat
    func openChat(userName: String, email: String) {
        
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VCSingleChatRoom") as! VCSingleChatRoom
        newViewController.chatWithUser      = userName
        newViewController.chatWithUserEmail = email
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    
}





