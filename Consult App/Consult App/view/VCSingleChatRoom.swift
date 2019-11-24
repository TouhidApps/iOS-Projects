//
//  VCSingleChatRoom.swift
//  Consult App
//
//  Created by Touhid on 9/13/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VCSingleChatRoom: UIViewController, UITextViewDelegate {
    
    private static let FDB_USERS: String = "users"
    
    @IBOutlet weak var chatTableView     : UITableView!
    @IBOutlet weak var textViewChatInput : UITextView!
    
    var chatWithUser        : String = ""
    var chatWithUserEmail   : String = ""
    
    var chatModel = [ChatModel]()
    
    var fdbRef          : DatabaseReference!
    var fdbChatRoomRef  : DatabaseReference!
    
    var email                 : String = ""
    var emailSplit            : [String.SubSequence] = []
    var emailUserName         : String = ""
    var emailDomain           : String = ""
    var chatWithEmailSplit    : [String.SubSequence] = []
    var chatWithEmailUserName : String = ""
    
    
    @IBAction func buttonSend(_ sender: UIButton) {
        // user name given email first part it should be updated by name
        sendMessage(message: textViewChatInput.text)
        self.textViewChatInput.text = ""
    }
    
    
    override func viewDidLayoutSubviews() {
        self.chatTableView.estimatedRowHeight = 85
        self.chatTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.chatWithUser
        
        
        // Placeholder
        textViewChatInput.delegate  = self
        textViewChatInput.text      = MyConstants.PLACEHOLDER_SAY_SOMETING
        textViewChatInput.textColor = UIColor.lightGray

        email           = UserDefaults.standard.string(forKey: MyConstants.USER_LOGIN_EMAIL)!
        emailSplit      = email.split(separator: "@")
        emailUserName   = String(emailSplit[0])
        emailDomain     = String(emailSplit[1]).replacingOccurrences(of: ".", with: "_")
        
        chatWithEmailSplit    = chatWithUserEmail.split(separator: "@")
        chatWithEmailUserName = String(chatWithEmailSplit[0])
      //  let myEmailDomain = String(myEmailSplit[1]).replacingOccurrences(of: ".", with: "_")
        
        self.fdbRef = Database.database().reference()
        self.fdbChatRoomRef = self.fdbRef
                                .child(VCSingleChatRoom.FDB_USERS)
                                .child(emailDomain)
                                .child(getChatRoomByEmail(myEmail: emailUserName, chatEmail: chatWithEmailUserName))
        
        // when data changed or added
        self.fdbChatRoomRef.observe(DataEventType.value, with: { (snapshot) in
            self.manageFirebaseSnapshot(firebaseSnapshot: snapshot)
        })
        
      
        
        
    } // END viewDidLoad
    
    func manageFirebaseSnapshot(firebaseSnapshot: DataSnapshot) {
        self.chatModel.removeAll()
        for mKey in firebaseSnapshot.children {
            guard let mSnapshot = mKey as? DataSnapshot else {
                continue
            }
            
            let mValue = mSnapshot.value as? NSDictionary
            
            let email     = mValue?["email"     ] as? String ?? ""
            let userName  = mValue?["userName"  ] as? String ?? ""
            let chatText  = mValue?["chatText"  ] as? String ?? ""
            
            var cModel = ChatModel()
            cModel.email     = email
            cModel.userName  = userName
            cModel.chatText  = chatText
            
            if chatText != ""{
                self.chatModel.append(cModel)
            }
            
        }
        
        self.chatTableView.reloadData()
        if self.chatModel.count > 2 {
            let indexPath = IndexPath(row: self.chatModel.count-1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    
    func sendMessage(message: String) {
        self.fdbChatRoomRef
            .childByAutoId()
            .setValue([
                    "email"    : email,
                    "userName" : emailUserName,
                    "chatText" : message
                ])
        
    }

    func getChatRoomByEmail(myEmail: String, chatEmail: String) -> String {
        var arr: [String] = [myEmail, chatEmail]
        arr.sort()

        return arr[0] + "__" + arr[1]
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textViewChatInput.textColor == UIColor.lightGray {
            textViewChatInput.text      = ""
            textViewChatInput.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textViewChatInput.text == "" {
            textViewChatInput.text      = MyConstants.PLACEHOLDER_SAY_SOMETING
            textViewChatInput.textColor = UIColor.lightGray
        }
    }

}

struct ChatModel {
    var email           : String = ""
    var userName        : String = ""
    var chatText        : String = ""
}


