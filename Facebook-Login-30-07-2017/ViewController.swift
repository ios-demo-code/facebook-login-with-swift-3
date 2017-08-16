//
//  ViewController.swift
//  Facebook-Login-30-07-2017
//
//  Created by Soeng Saravit on 7/30/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.delegate = self
        loginButton.readPermissions = ["email","public_profile"]
        self.view.addSubview(loginButton)
        
        isHideElement(b: true)
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
            
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id,name,email,gender"]).start(completionHandler: { (connection, results, error) in
                if error == nil {
                    self.isHideElement(b: false)
                    let user:[String:Any] = results as! [String:Any]
                    
                    let fid = user["id"] as! String
                    self.userNameLabel.text = user["name"] as! String?
                    self.emailLabel.text = user["email"] as! String?
                    self.genderLabel.text = user["gender"] as! String?
                    
                    let url = URL(string: "https://graph.facebook.com/\(fid)/picture?type=large")
                    
                    let data = try? Data(contentsOf: url!)
                    self.profileImageView.image = UIImage(data: data!)
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        isHideElement(b: true)
    }
   
    func isHideElement(b:Bool) {
        self.profileImageView.isHidden = b
        self.userNameLabel.isHidden = b
        self.emailLabel.isHidden = b
        self.genderLabel.isHidden = b
    }


}

