//
//  ScannerViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 31/05/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate, ScannerDelegate {
private var scanner: Scanner?

override func viewDidLoad() {
    super.viewDidLoad()
    
    self.scanner = Scanner(withDelegate: self)
    
    guard let scanner = self.scanner else {
        return
    }
    
    scanner.requestCaptureSessionStartRunning()
}
    override open var shouldAutorotate: Bool {
       return false
    }

    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }
     
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

// Mark - AVFoundation delegate methods
public func metadataOutput(_ output: AVCaptureMetadataOutput,
                           didOutput metadataObjects: [AVMetadataObject],
                           from connection: AVCaptureConnection) {
    guard let scanner = self.scanner else {
        return
    }
    scanner.metadataOutput(output,
                           didOutput: metadataObjects,
                           from: connection)
}

// Mark - Scanner delegate methods
func cameraView() -> UIView
{
    return self.view
}

func delegateViewController() -> UIViewController
{
    return self
}

func scanCompleted(withCode code: String)
{
    print(code)
    self.dismiss(animated: true, completion: {})
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
