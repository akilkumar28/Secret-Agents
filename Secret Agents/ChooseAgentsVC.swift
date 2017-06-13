//
//  ChooseAgentsVC.swift
//  Secret Agents
//
//  Created by AKIL KUMAR THOTA on 6/13/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase

class ChooseAgentsVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var uniqueName:String!
    var detail:String!
    var imageUrl:String!
    
    var agents = [Agent]()
    
    @IBOutlet weak var mytableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef.child("Users").observe(.childAdded) { (snapshot:DataSnapshot) in
            let agent = Agent()
            
            if let value = snapshot.value as? Dictionary<String,Any> {
                if let email = value["Email"] as? String {
                    agent.email = email
                }
            }
            agent.uid = snapshot.key
            
            self.agents.append(agent)
            self.mytableView.reloadData()
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = agents[indexPath.row].email
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let agent = agents[indexPath.row]
        let missionDict = ["uniqueName" : self.uniqueName,
                           "imageUrl" : self.imageUrl,
                           "details": self.detail,
                           "from":Auth.auth().currentUser?.email]
        databaseRef.child("Users").child(agent.uid).child("missions").childByAutoId().setValue(missionDict)
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    
    
    
    
    
    
    
  

}
