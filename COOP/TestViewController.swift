//
//  TestViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 19/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var id = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var lblNaam: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblNaam.text = String.init(describing: id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestPage()
    }

    func requestPage() {
        let url = URL(string: "http://")
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration:URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            // check for errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with:responseData, options: []) as? [String: AnyObject]
                    else {
                        print("Todo Error")
                        return
                }
                guard let naam = (json["naam"]) as? String else {
                    print ("array error")
                    return
                }
                DispatchQueue.main.async {
                    self.lblNaam.text = naam
                    do {
                        try self.context.save()
                    }
                    catch {
                        print("error met core data")
                    }
                }
                
                
            } catch {
                print("Big error")
                return
            }
            
        }
        task.resume()

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
