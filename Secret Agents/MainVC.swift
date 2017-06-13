//
//  MainVC.swift
//  Secret Agents
//
//  Created by AKIL KUMAR THOTA on 6/13/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase


class MainVC: UIViewController {

    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var psswdTxtFld: UITextField!
    @IBOutlet weak var logInSignInBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInSignInBtn.isEnabled = false
        logInSignInBtn.alpha = 0.5
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editingEnded(_ sender: Any) {
        
        if emailTxtFld.text == "" || psswdTxtFld.text == "" {
            logInSignInBtn.isEnabled = false
            logInSignInBtn.alpha = 0.5
        } else {
            logInSignInBtn.isEnabled = true
            logInSignInBtn.alpha = 1
        }
       
    }
    
    @IBAction func editingBegan(_ sender: Any) {
        
        logInSignInBtn.isEnabled = true
        logInSignInBtn.alpha = 1

        
    }

    
    
    
    

    @IBAction func logInSignInPrsd(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTxtFld.text!, password: psswdTxtFld.text!) { (user, error) in
            if error != nil {
                
                Auth.auth().createUser(withEmail: self.emailTxtFld.text!, password: self.psswdTxtFld.text!, completion: { (user, error) in
                    
                    if error != nil {
                        self.errorLbl.text = error?.localizedDescription
                    } else {
                        self.errorLbl.text = "Created an Account Successfully"
                        Auth.auth().signIn(withEmail: self.emailTxtFld.text!, password: self.psswdTxtFld.text!, completion: { (user, error) in
                            if error != nil {
                                self.errorLbl.text = error?.localizedDescription
                            } else {
                                self.errorLbl.text = "Registered Successfully"
                                
                                databaseRef.child("Users").child(user!.uid).child("Email").setValue(self.emailTxtFld.text!)
                                databaseRef.child("Users").child(user!.uid).child("Password").setValue(self.psswdTxtFld.text!)
                                
                                self.performSegue(withIdentifier: "HomeVC", sender: nil)
                            }
                        })
                        
                    }
                })
                
            } else{
                self.errorLbl.text = "Sign In Successfull"
                self.performSegue(withIdentifier: "HomeVC", sender: nil)
            }
        }
        
        
    }

}

