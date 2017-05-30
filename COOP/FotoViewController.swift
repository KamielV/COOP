//
//  FotoViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 29/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//
////foto tutorial http://www.oodlestechnologies.com/blogs/Open-Image-Gallery-and-Take-photo-in-Swift

import UIKit

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var btnTrekFoto: UIButton!
    @IBOutlet weak var btnVerstuur: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker?.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker!.allowsEditing = false
            imagePicker!.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker!.cameraCaptureMode = .photo
            present(imagePicker!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(InfoViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        configureViewFromLocalisation()
        // Do any additional setup after loading the view.
        btnTrekFoto.layer.cornerRadius = 20
        btnTrekFoto.layer.shadowColor = UIColor.white.cgColor
        btnTrekFoto.layer.shadowOpacity = 6
        btnTrekFoto.layer.shadowOffset = CGSize.zero
        btnTrekFoto.layer.shadowRadius = 25
        
        btnVerstuur.layer.cornerRadius = 20
        btnVerstuur.layer.shadowColor = UIColor.white.cgColor
        btnVerstuur.layer.shadowOpacity = 6
        btnVerstuur.layer.shadowOffset = CGSize.zero
        btnVerstuur.layer.shadowRadius = 25
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureViewFromLocalisation() {
        title = Localization("LocalisatorViewTitle")
        btnTrekFoto.setTitle(Localization("btnTrekFoto"), for: .normal)
        btnVerstuur.setTitle(Localization("btnVerstuur"), for: .normal)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgFoto.contentMode = .scaleAspectFit
        imgFoto.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnNeemfoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker!.allowsEditing = false
            imagePicker!.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker!.cameraCaptureMode = .photo
            present(imagePicker!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // verstuur data van https://stackoverflow.com/questions/44103973/swift-php-cant-upload-image
    
    @IBAction func btnVerstuurData(_ sender: Any) {
        uploadFoto()
    }
    
    func uploadFoto() {
        let uploadScriptUrl = URL(string: "http://10.3.210.48:8080/coop/api/upload.php")
        
        let session = URLSession.shared
        
        let param = ["groepId":"a1a1"]
        
        let imageData = UIImagePNGRepresentation(imgFoto.image!)
        
        if(imageData == nil )  { return }
        
        let boundary = generateBoundaryString()
        
        let request = NSMutableURLRequest(url: uploadScriptUrl!)
        request.httpMethod = "POST"
        
        request.httpBody = createBodyWithParameters(param as [String : String], filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (imgFoto.image == nil)
        {
            print("image error")
            return
        }
        
        
        if(imageData == nil)
        {
            print("image data error")
            return
        }
        
        
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard ((data) != nil), let _:URLResponse = response, error == nil else {
                print(error!)
                return
            }
            print("\(String(describing: response!))")
            print("\(String(describing: data?.description))")
            print(error!)
            do {
                guard let json = try JSONSerialization.jsonObject(with:data!, options: .allowFragments) as? [String: AnyObject]
                    else {
                        print("json Error")
                        return
                }
                print(json)
                
            }
            catch {
                print(error)
                return
            }
        })
        
        
        task.resume()
    }
    
    func createBodyWithParameters(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "groepsfoto\(day)-\(month)-\(year)-\(hour)_\(minutes)_\(second).png"
        
        let mimetype = "image/png"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body as Data
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
    
}
//add appendString function
extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
