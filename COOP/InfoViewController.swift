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
    @IBOutlet weak var btnStartScannen: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            coreData = try context.fetch(CoreData.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        // kopieren in de view did load
        NotificationCenter.default.addObserver(self, selector: #selector(InfoViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        configureViewFromLocalisation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureViewFromLocalisation() {
        lblScan.text = Localization("ScanText")
        btnStartScannen.setTitle(Localization("btnStartScannen"), for: .normal)
    }
    
    // MARK: - Notification methods
    
    func receiveLanguageChangedNotification(notification:NSNotification) {
        if notification.name == kNotificationLanguageChanged {
            configureViewFromLocalisation()
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
