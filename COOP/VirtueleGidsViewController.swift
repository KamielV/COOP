//
//  VirtueleGidsViewController.swift
//  COOP
//
//  Created by Robert Vander weyden on 24/05/17.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//

import UIKit
import AVFoundation

class VirtueleGidsViewController: UIViewController {
    
    var playing = false
    var coreData: [CoreData] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var url: URL!
    var taal: String!
    var testURL = URL(string: "http://10.3.210.48:8080/coop/api/heyvae02/")
    var player:AVPlayer = AVPlayer()
    
    @IBOutlet weak var ViewTransparantContainer: UIView!
    
    @IBOutlet weak var imgThemaFoto: UIImageView!
    @IBOutlet weak var imgAfbeelding: UIImageView!
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var langeTeksLabel: UILabel!
    
    @IBOutlet weak var BtnPLay: UIButton!
    @IBOutlet weak var sliderMp3: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            coreData = try context.fetch(CoreData.fetchRequest())
            taal = coreData[0].taal
        } catch {
            print("Fetching Failed")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(InfoViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        configureViewFromLocalisation()
        
       ViewTransparantContainer.layer.cornerRadius = 11
        ViewTransparantContainer.layer.shadowColor = UIColor.black.cgColor
        ViewTransparantContainer.layer.shadowOpacity = 6
        ViewTransparantContainer.layer.shadowOffset = CGSize.zero
        ViewTransparantContainer.layer.shadowRadius = 11
        

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
    
    @IBAction func sliderValuaChanged(_ sender: Any) {
        
    }
    
    func configureViewFromLocalisation() {
        title = Localization("LocalisatorViewTitle")
        titelLabel.text = Localization("TitelTekstgids")
    }
    
    func getData() {
        do {
            coreData = try context.fetch(CoreData.fetchRequest())
            taal = coreData[0].taal
        } catch {
            print("Fetching Failed")
        }
    }
    func requestPage() {
        var urlRequest: URLRequest!
        if (url != nil) {
            let tempCoreData = CoreData(context: self.context)
            tempCoreData.url = "\(url.absoluteString)\\\(taal)"
            self.url = URL(string: tempCoreData.url!)
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
            self.url = URL(string: "\(tempCoreData.url!)\\\(taal)")
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
                    self.titelLabel.text = titel
                    self.subtitleLabel.text = subtitel
                    self.imgThemaFoto.image = UIImage(named: themafoto)
                    self.langeTeksLabel.text = beschrijving
                    self.imgAfbeelding.image = UIImage(named: afbeelding)
                    //AVPlayer https://stackoverflow.com/questions/42651163/how-to-make-uislider-match-audio-progress
                    let player = AVPlayer(url: Bundle.main.url(forResource: audiofile, withExtension: "mp3")!)
                    player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 30), queue: .main) { time in
                            let fraction = CMTimeGetSeconds(time) / CMTimeGetSeconds(player.currentItem!.duration)
                            self.sliderMp3.value = Float(fraction)
                    }
                    print("Audio load error")
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
            BtnPLay.setImage(#imageLiteral(resourceName: "pauseButton") , for: .normal)
        }
        else {
            player.pause()
            playing = false
            BtnPLay.setImage(#imageLiteral(resourceName: "playButton") , for: .normal)
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
