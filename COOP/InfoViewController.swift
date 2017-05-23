//
//  InfoViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 18/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let arrayLanguages = Localisator.sharedInstance.getArrayAvailableLanguages()

    @IBOutlet weak var lblScan: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(InfoViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        configureViewFromLocalisation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureViewFromLocalisation() {
        title = Localization("LocalisatorViewTitle")
        lblScan.text = Localization("ScanText")
    }
    
    // MARK: - Notification methods
    
    func receiveLanguageChangedNotification(notification:NSNotification) {
        if notification.name == kNotificationLanguageChanged {
            configureViewFromLocalisation()
        }
    }
    @IBAction func btnNLTouched(_ sender: Any) {
        if SetLanguage("Dutch_nl") {
            let alert = UIAlertController(title: Localization("languageChangedWarningMessage"), message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
            self.present(alert, animated: true)
        }
    }
    

    @IBAction func btnFRTouched(_ sender: Any) {
        if SetLanguage("French_fr") {
            let alert = UIAlertController(title: Localization("languageChangedWarningMessage"), message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
            self.present(alert, animated: true)
        }
    }
    @IBAction func btnENTouched(_ sender: Any) {
        if SetLanguage("English_en") {
            let alert = UIAlertController(title: Localization("languageChangedWarningMessage"), message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
            self.present(alert, animated: true)
        }
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
