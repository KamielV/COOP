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
    let antwoorden = [["2", "3", "4"], ["Léon", "Merlin", "Robert"], ["pintjes", "Integration", "COOP"]]
    var currVraag = 0
    var juisteVraag:UInt32 = 0
    var points = 0;
    
    //viewDid functies
    override func viewDidAppear(_ animated: Bool) {
        nieuweVraag()
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
    @IBAction func btnVraagClicked(_ sender: UIButton)
    {
        if (sender.tag == Int(juisteVraag))
        {
            sender.setTitleColor(UIColor.green, for: .normal)
            print ("juist")
            points += 1
        }
        else
        {
            sender.setTitleColor(UIColor.red, for: .normal)
            print ("fout")
        }
        
        if (currVraag != vragen.count)
        {
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                sender.setTitleColor(UIColor.blue, for: .normal)
                self.nieuweVraag()
            }
            
        }
        else
        {
            performSegue(withIdentifier: "showScore", sender: self)
        }
    }
    
    //segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showScore")  {
            let nextVC = segue.destination as? ScoreViewController
            //nextVC?.score = points
        }
    }
    
    //nieuwe vraag
    func nieuweVraag() {
        lblPunten.text = "\(points)"
        lblVraagHoeveel.text = "\(currVraag) \\ \(vragen.count)"
        lblVraag.text = vragen[currVraag]
        
        //https://swift3tutorials.com/swift-3-while-statements-2/
        juisteVraag = arc4random_uniform(3)+1
        
        //Create a button
        var button:UIButton = UIButton()
        
        var x = 1
        
        for i in 1...3
        {
            //Create a button
            button = view.viewWithTag(i) as! UIButton
            
            if (i == Int(juisteVraag))
            {
                button.setTitle(antwoorden[currVraag][0], for: .normal)
            }
            else
            {
                button.setTitle(antwoorden[currVraag][x], for: .normal)
                x = 2
            }
        }
        currVraag += 1
        
    }

}
