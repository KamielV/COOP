//
//  VirtueleGidsViewViewController.swift
//  COOP
//
//  Created by Robert Vander weyden on 22/05/17.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class VirtueleGidsViewViewController: UIViewController {

    @IBOutlet weak var transparantView: UIView!
   // @IBOutlet weak var tekstFotoView: UIImageView!
    
    @IBOutlet weak var mp3PlayerGids: UIView!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // transparentView 
        
        transparantView.layer.cornerRadius = 6
        transparantView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        transparantView.layer.shadowOffset = CGSize(width: 3.5, height: 3.5)
        transparantView.layer.shadowRadius = 1.7
        transparantView.layer.shadowOpacity = 0.45
        
        //audioplayerView
        
        
        
        
        mp3PlayerGids.layer.cornerRadius = 6
        mp3PlayerGids.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        mp3PlayerGids.layer.shadowOffset = CGSize(width: 3.5, height: 3.5)
        mp3PlayerGids.layer.shadowRadius = 1.7
        mp3PlayerGids.layer.shadowOpacity = 0.45

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
