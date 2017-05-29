//
//  VirtueleGidsViewController.swift
//  COOP
//
//  Created by Robert Vander weyden on 24/05/17.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class VirtueleGidsViewController: UIViewController {
    
    
    @IBOutlet weak var ViewTransparantContainer: UIView!
    
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var langeTeksLabel: UILabel!
    
    @IBOutlet weak var BtnPLay: UIButton!
    @IBOutlet weak var sliderMp3: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       ViewTransparantContainer.layer.cornerRadius = 11
        ViewTransparantContainer.layer.shadowColor = UIColor.black.cgColor
        ViewTransparantContainer.layer.shadowOpacity = 6
        ViewTransparantContainer.layer.shadowOffset = CGSize.zero
        ViewTransparantContainer.layer.shadowRadius = 11
        

        // Do any additional setup after loading the view.
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
