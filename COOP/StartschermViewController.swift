//
//  StartschermViewController.swift
//  COOP
//
//  Created by ZAÏM Camil (s) on 22/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class StartschermViewController: UIViewController {
    
    var coreData: [CoreData] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let arrayLanguages = Localisator.sharedInstance.getArrayAvailableLanguages()

    @IBOutlet weak var BtnNL: UIButton!
    @IBOutlet weak var BtnFR: UIButton!
    @IBOutlet weak var BtnEN: UIButton!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            coreData = try context.fetch(CoreData.fetchRequest())
        } catch {
            print("Fetching Failed")
        }

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnNLTouched(_ sender: Any) {
        if SetLanguage("Dutch_nl") {
            if(coreData.count == 0) {
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
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                self.gaNaarTutorial()
            })
            alert.addAction(UIAlertAction(title: Localization("Cancel"), style: .cancel) { action in
                print("Cancel")
            })
            self.present(alert, animated: true)
        }
    }
    
    
    @IBAction func btnFRTouched(_ sender: Any) {
        if SetLanguage("French_fr") {
            if(coreData.count == 0) {
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
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                self.gaNaarTutorial()
            })
            alert.addAction(UIAlertAction(title: Localization("Cancel"), style: .cancel) { action in
                print("Cancel")
            })
            self.present(alert, animated: true)
        }
    }
    @IBAction func btnENTouched(_ sender: Any) {
        if SetLanguage("English_en") {
            if(coreData.count == 0) {
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
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                self.gaNaarTutorial()
            })
            alert.addAction(UIAlertAction(title: Localization("Cancel"), style: .cancel) { action in
                print("Cancel")
            })
            self.present(alert, animated: true)
        }
    }
    
    func gaNaarTutorial() {
        performSegue(withIdentifier: "toTutorial", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toTutorial")  {
            let nextVC = segue.destination as? SwiftViewController
        }
    }

}
