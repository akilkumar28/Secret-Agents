//
//  SendMissionVC.swift
//  Secret Agents
//
//  Created by AKIL KUMAR THOTA on 6/13/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit

class SendMissionVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var missionDescTxtFld: UITextField!
    
    @IBOutlet weak var chooseAgentBtn: UIButton!
    
    let imagePicker = UIImagePickerController()
    let uniqueName = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        chooseAgentBtn.isEnabled = false
        chooseAgentBtn.alpha = 0.5
    }
    
    
    
    
    
    @IBAction func chooseAgentClicked(_ sender: Any) {
        
        chooseAgentBtn.isEnabled = false
        
        let uploadeImage = UIImageJPEGRepresentation(self.myImageView.image!, 0.1)
        
        storageref.child("missionImages").child("\(uniqueName).jpg").putData(uploadeImage!, metadata: nil) { (metadata, error) in
            if error != nil {
                print("######  Upload image error occured")
            } else {
                self.performSegue(withIdentifier: "chooseAgents", sender: metadata?.downloadURL()?.absoluteString)
            }
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChooseAgentsVC {
            
            destination.uniqueName = self.uniqueName
            destination.detail = missionDescTxtFld.text!
            destination.imageUrl = sender as! String
        }
    }
    
    @IBAction func cameraBtnTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chooseAgentBtn.isEnabled = true
        chooseAgentBtn.alpha = 1
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.myImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    

 

}
