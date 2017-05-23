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
    // verstuur data van http://www.kaleidosblog.com/how-to-upload-images-using-swift-2-send-multipart-post-request
    @IBAction func btnVerstuurData(_ sender: Any) {
        let url = URL(string: "sitemerlinhier")
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (imgFoto.image == nil)
        {
            print("no foto found")
            return
        }
        
        let image_data = UIImageJPEGRepresentation(imgFoto.image!, 1.0)
        
        
        if(image_data == nil)
        {
            print("no data found")
            return
        }
        
        
        let body = NSMutableData()
        
        let filename = "groepfoto.jpg"
        let mimetype = "image/jpg"
        
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"foto\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        
        request.httpBody = body as Data
        
        
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard ((data) != nil), let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
            }
            
        }) 
        
        task.resume()
        
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }

}
