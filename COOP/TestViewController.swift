//
//  TestViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 19/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var name: String!

    @IBOutlet weak var lblNaam: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblNaam.text = name
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
