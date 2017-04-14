//
//  CameraViewController.swift
//  SnapchatSwipeView
//
//  Created by Zhongheng Li on 4/14/17.
//  Copyright © 2017 Brendan Lee. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


@available(iOS 10.0, *)
class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    
    var session = AVCaptureSession()
    var stillImageOutput = AVCapturePhotoOutput()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    var thisImage: UIImage!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var takePicture: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
     
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session.canAddInput(input) {
            session.addInput(input)
            // ...
            // The remainder of the session setup will go here...
            
           // stillImageOutput = AVCaptureStillImageOutput()
           // stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if session.canAddOutput(stillImageOutput) {
                session.addOutput(stillImageOutput)
                // ...
                // Configure the Live Preview here...
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
                videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect
                videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                previewView.layer.addSublayer(videoPreviewLayer)
                previewView.addSubview(takePicture)
                
                videoPreviewLayer.position = CGPoint (x: self.previewView.frame.width/2, y: self.previewView.frame.height/2)
                videoPreviewLayer.bounds = previewView.frame
                
                session.startRunning()
            }
            
            
            
            
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer.frame = previewView.bounds
    }
    
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            
            self.thisImage = UIImage(data: dataImage)
            
            print("There is Image:" , self.thisImage)
            
        }
        
    }
    
    
    
    
    
    
    @IBAction func takePhoto(_ sender: Any) {
        
        
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String : previewPixelType, kCVPixelBufferWidthKey as String : 160, kCVPixelBufferHeightKey as String : 160]
        
        settings.previewPhotoFormat = previewFormat
        stillImageOutput.capturePhoto(with: settings, delegate: self)

    }
    
    
  
}
