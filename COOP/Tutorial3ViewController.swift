//
//  Tutorial3ViewController.swift
//  COOP
//
//  Created by Robert Vander weyden on 29/05/17.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class Tutorial3ViewController: UIViewController {
    @IBOutlet weak var LblTut3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(InfoViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        configureViewFromLocalisation()

        // Do any additional setup after loading the view.
    }
    
    func configureViewFromLocalisation() {
        title = Localization("LocalisatorViewTitle")
        LblTut3.text = Localization("LblTut3")
        
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
