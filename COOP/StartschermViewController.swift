//
//  StartschermViewController.swift
//  COOP
//
//  Created by ZAÏM Camil (s) on 22/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class StartschermViewController: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnStart.layer.cornerRadius = 11;
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
