//
//  CodeViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 23/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {
    
    var url: URL!
    
    @IBOutlet weak var imgBijAfbeelding: UIImageView!
    @IBOutlet weak var lblCodeAmount: UILabel!
    @IBOutlet weak var imgCodeAfbeelding: UIImageView!
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblSubtitel: UILabel!
    @IBOutlet weak var lblText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func requestPage() {
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration:URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            // check for errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            
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
                guard let titel = (json["titel"]) as? String else {
                    print ("array error")
                    return
                }
                guard let subtitel = (json["subtitel"]) as? String else {
                    print ("array error")
                    return
                }
                guard let themafoto = (json["themafoto"]) as? String else {
                    print ("array error")
                    return
                }
                guard let beschrijving = (json["beschrijving"]) as? String else {
                    print ("array error")
                    return
                }
                guard let audiofile = (json["audiofile"]) as? String else {
                    print ("array error")
                    return
                }
                guard let afbeelding = (json["afbeelding"]) as? String else {
                    print ("array error")
                    return
                }
                DispatchQueue.main.async {
                    
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
