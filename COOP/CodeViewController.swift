//
//  CodeViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 23/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit
import AVFoundation

class CodeViewController: UIViewController {
    
    var playing = false
    var coreData: [CoreData] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var url: URL!
    var testURL = URL(string: "http://10.3.210.37:8080/coop/api/heyvae02/")
    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var imgThemafoto: UIImageView!
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblSubtitel: UILabel!
    @IBOutlet weak var lblBeschrijving: UILabel!
    @IBOutlet weak var imgAfbeelding: UIImageView!
    @IBOutlet weak var btnPlayPause: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            coreData = try context.fetch(CoreData.fetchRequest())
        } catch {
            print("Fetching Failed")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        requestPage()
    }
    func getData() {
        do {
            coreData = try context.fetch(CoreData.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    func requestPage() {
        var urlRequest: URLRequest!
        if (url != nil) {
            let tempCoreData = CoreData(context: self.context)
            tempCoreData.url = url.absoluteString
            self.context.insert(tempCoreData)
            do {
                try self.context.save()
            }
            catch {
                print("error met core data")
            }
            urlRequest = URLRequest(url: url!)
        }
        else {
            let tempCoreData = coreData[0]
            self.url = URL(string: tempCoreData.url!)
            urlRequest = URLRequest(url: url)
        }
        
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
                    print ("titel error")
                    return
                }
                guard let subtitel = (json["subtitel"]) as? String else {
                    print ("subtitel error")
                    return
                }
                guard let themafoto = (json["themafoto"]) as? String else {
                    print ("themafoto error")
                    return
                }
                guard let beschrijving = (json["beschrijving"]) as? String else {
                    print ("beschrijving error")
                    return
                }
                guard let audiofile = (json["audiofile"]) as? String else {
                    print ("audiofile error")
                    return
                }
                guard let afbeelding = (json["afbeelding"]) as? String else {
                    print ("afbeelding error")
                    return
                }
                DispatchQueue.main.async {
                    self.lblTitel.text = titel
                    self.lblSubtitel.text = subtitel
                    self.imgThemafoto.image = UIImage(named: themafoto)
                    self.lblBeschrijving.text = beschrijving
                    self.imgAfbeelding.image = UIImage(named: afbeelding)
                    do {
                        let audioPath = Bundle.main.path(forResource: audiofile, ofType: "mp3")
                        try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                    }
                    catch {
                        print("Audio load error")
                    }
                }
                
                
            } catch {
                print("Big error")
                return
            }
            
        }
        task.resume()
        
    }
    
    @IBAction func btnPlayTouched(_ sender: Any) {
        if(!playing)
        {
            player.play()
            playing = true
            btnPlayPause.setImage(#imageLiteral(resourceName: "pauseButton") , for: .normal)
        }
        else {
            player.pause()
            playing = false
            btnPlayPause.setImage(#imageLiteral(resourceName: "playButton") , for: .normal)
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
