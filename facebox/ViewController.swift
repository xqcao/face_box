//
//  ViewController.swift
//  facebox
//
//  Created by xiaoqiang cao on 5/1/18.
//  Copyright © 2018 xiaoqiang cao. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named:"iphone") else { return}
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        
        
        let scaleHeight = view.frame.width/image.size.width * image.size.height
//        imageView.frame = CGRect(x: 0,y:0,width:view.frame.width,height:220)
        
        imageView.frame = CGRect(x: 0,y:20,width:view.frame.width,height:scaleHeight)

        view.addSubview(imageView)
//        imageView.backgroundColor = .red
        
        let request = VNDetectFaceRectanglesRequest{ (req,err)
            in
            if let err = err{
                print("failed to detect face:",err)
                return
            }
//            print(req)
            req.results?.forEach({ (res) in
//                print(res)
                guard let faceObservation = res as?
                    VNFaceObservation else { return}
                let x = self.view.frame.width * faceObservation.boundingBox.origin.x

                let height = scaleHeight * faceObservation.boundingBox.height
                let y = scaleHeight * (1 - faceObservation.boundingBox.origin.y) - (height-20)
//                let y = scaleHeight * (1 -  faceObservation.boundingBox.origin.y) - height
                
                
                let width = self.view.frame.width * faceObservation.boundingBox.width

                
                let redView = UIView()
                redView.backgroundColor = .green
                redView.alpha = 0.3
                redView.frame = CGRect(x: x, y: y, width: width, height: height)
                self.view.addSubview(redView)
                
                
                
                print(faceObservation.boundingBox)
            })
        }
        guard let cgImage = image.cgImage else { return}
        
        let hander = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try hander.perform([request])
        } catch let reqErr {
            print("failed to perform request", reqErr)
        }
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

