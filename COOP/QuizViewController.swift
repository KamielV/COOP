//
//  QuizViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 22/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var lblPunten: UILabel!
    @IBOutlet weak var lblVraagHoeveel: UILabel!
    @IBOutlet weak var lblVraag: UILabel!
    
    //variabelen
    let vragen = ["Hoeveel is 1+1", "Wat is de voornaam van Moulart?", "Wat is het beste"]
    let antwoorden = [["2", "3", "4"], ["Robert", "Merlin", "Léon"], ["COOP", "Integration", "pintjes"]]
    var currVraag = 0
    var juisteVraag:UInt32 = 0
    var points = 0;
    
    //viewDid functies
    override func viewDidAppear(_ animated: Bool) {
        <#code#>
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //vraag clicked
    @IBAction func btnVraagClicked(_ sender: AnyObject)
    {
        if (sender.tag == Int(juisteVraag))
        {
            print ("RIGHT!")
            points += 1
        }
        else
        {
            print ("WRONG!!!!!!")
        }
        
        if (currVraag != vragen.count)
        {
            nieuweVraag()
        }
        else
        {
            performSegue(withIdentifier: "showScore", sender: self)
        }
    }
    
    //nieuwe vraag
    func nieuweVraag() {
        
    }

}
