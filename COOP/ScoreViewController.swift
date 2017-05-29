//
//  ScoreViewController.swift
//  COOP
//
//  Created by Robert Vander weyden on 26/05/17.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var BtnFoto: UIButton!
    @IBOutlet weak var BtnQr: UIButton!
    @IBOutlet weak var BtnQuiz: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BtnFoto.layer.cornerRadius = 20
        BtnFoto.layer.shadowColor = UIColor.white.cgColor
        BtnFoto.layer.shadowOpacity = 6
        BtnFoto.layer.shadowOffset = CGSize.zero
        BtnFoto.layer.shadowRadius = 25
        
        BtnQr.layer.cornerRadius = 20
        BtnQr.layer.shadowColor = UIColor.white.cgColor
        BtnQr.layer.shadowOpacity = 6
        BtnQr.layer.shadowOffset = CGSize.zero
        BtnQr.layer.shadowRadius = 25
        
        BtnQuiz.layer.cornerRadius = 20
        BtnQuiz.layer.shadowColor = UIColor.white.cgColor
        BtnQuiz.layer.shadowOpacity = 6
        BtnQuiz.layer.shadowOffset = CGSize.zero
        BtnQuiz.layer.shadowRadius = 25
        
        

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
