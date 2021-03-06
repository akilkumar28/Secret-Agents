//
//  HomeVC.swift
//  Secret Agents
//
//  Created by AKIL KUMAR THOTA on 6/13/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var missions = [Mission]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("missions").observe(.childAdded) { (snapshot:DataSnapshot) in
            let mission = Mission()
            if let stages = snapshot.value as? Dictionary<String,Any> {
                if let detail = stages["details"] as? String {
                    mission.detail = detail
                }
                if let from = stages["from"] as? String {
                    mission.from = from
                }
                if let imageUrl = stages["imageUrl"] as? String {
                    mission.imageUrl = imageUrl
                }
                if let uniqueName = stages["uniqueName"] as? String {
                    mission.uniqueName = uniqueName
                }
                mission.key = snapshot.key
                
                self.missions.append(mission)
                self.myTableView.reloadData()
            }
        }
        
        databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("missions").observe(.childRemoved) { (snapshot:DataSnapshot) in
            
            var index = 0
            for mission in self.missions {
                if mission.key == snapshot.key {
                   self.missions.remove(at: index)
                }
                index += 1
            }
            self.myTableView.reloadData()
            
        }
        
        
        
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.missions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text  = missions[indexPath.row].uniqueName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mission = missions[indexPath.row]
        performSegue(withIdentifier: "missionDetails", sender: mission)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MissionDetailsVC {
            destination.mission = sender as! Mission
        }
    }
    

   

}
