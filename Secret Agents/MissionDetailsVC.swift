//
//  MissionDetailsVC.swift
//  Secret Agents
//
//  Created by AKIL KUMAR THOTA on 6/13/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MissionDetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var missionDetailsLbl: UILabel!
    
    @IBOutlet weak var fromLbl: UILabel!
    
    
    var mission = Mission()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionDetailsLbl.text = mission.detail
        fromLbl.text = mission.from
        imageView.sd_setImage(with: URL(string:mission.imageUrl))

    }

    @IBAction func acceptPrsd(_ sender: Any) {
    }

    @IBAction func rejectPrsd(_ sender: Any) {
    }
  
}
