//
//  InfoViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 18/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var coreData: [CoreData] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let arrayLanguages = Localisator.sharedInstance.getArrayAvailableLanguages()

    @IBOutlet weak var lblScan: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            coreData = try context.fetch(CoreData.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
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
            if(coreData[0].taal == nil) {
                let tempCoreData = CoreData(context: self.context)
                tempCoreData.taal = "nl"
                self.context.insert(tempCoreData)
                do {
                    try self.context.save()
                }
                catch {
                    print("error met core data")
                }
            }
            else {
                let tempTaal = "nl"
                coreData[0].taal = tempTaal
                do {
                    try self.context.save()
                }
                catch {
                    print("error met core data")
                }
            }
            let alert = UIAlertController(title: Localization("languageChangedWarningMessage"), message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
            self.present(alert, animated: true)
        }
    }
    

    @IBAction func btnFRTouched(_ sender: Any) {
        if SetLanguage("French_fr") {
            if(coreData[0].taal == nil) {
                let tempCoreData = CoreData(context: self.context)
                tempCoreData.taal = "fr"
                self.context.insert(tempCoreData)
                do {
                    try self.context.save()
                }
                catch {
                    print("error met core data")
                }
            }
            else {
                let tempTaal = "fr"
                coreData[0].taal = tempTaal
                do {
                    try self.context.save()
                }
                catch {
                    print("error met core data")
                }
            }
            let alert = UIAlertController(title: Localization("languageChangedWarningMessage"), message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
            self.present(alert, animated: true)
        }
    }
    @IBAction func btnENTouched(_ sender: Any) {
        if SetLanguage("English_en") {
            if(coreData[0].taal == nil) {
                let tempCoreData = CoreData(context: self.context)
                tempCoreData.taal = "en"
                self.context.insert(tempCoreData)
                do {
                    try self.context.save()
                }
                catch {
                    print("error met core data")
                }
            }
            else {
                let tempTaal = "en"
                coreData[0].taal = tempTaal
                do {
                    try self.context.save()
                }
                catch {
                    print("error met core data")
                }
            }
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
