//
//  FotoViewController.swift
//  COOP
//
//  Created by VIJVERMAN Kamiel (s) on 22/05/2017.
//  Copyright © 2017 VIJVERMAN Kamiel (s). All rights reserved.
//
//foto tutorial http://www.oodlestechnologies.com/blogs/Open-Image-Gallery-and-Take-photo-in-Swift

import UIKit

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet weak var imgFoto: UIImageView!
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // verstuur data van https://stackoverflow.com/questions/44103973/swift-php-cant-upload-image
    
    @IBAction func btnVerstuurData(_ sender: Any) {
        uploadFoto()
        }
    
    func uploadFoto() {
        
        let param = ["groepId":"a1a1"]
        
        let imageData = UIImageJPEGRepresentation(imgFoto.image!, 1)
        
        if(imageData == nil )  { return }
        
        let uploadScriptUrl = URL(string: "http://10.3.210.74/coop/api/upload.php")
        
        let boundary = generateBoundaryString()
        
        let request = NSMutableURLRequest(url: uploadScriptUrl!)
        request.httpMethod = "POST"
        
        request.httpBody = createBodyWithParameters(param as [String : String], filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (imgFoto.image == nil)
        {
            return
        }
        
        
        if(imageData == nil)
        {
            return
        }
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard ((data) != nil), let _:URLResponse = response, error == nil else {
                print(error!)
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
            }
            
        })
        
        
        task.resume()
    }
    
    func createBodyWithParameters(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "groepsfoto.jpg"
        
        let mimetype = "image/jpg"
        
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
