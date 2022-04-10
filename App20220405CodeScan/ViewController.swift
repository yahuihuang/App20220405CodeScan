//
//  ViewController.swift
//  App20220405CodeScan
//
//  Created by grace on 2022/4/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    let avCaptureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCodeScan()
    }

    func setCodeScan() {
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else { return }
        avCaptureSession.addInput(avCaptureInput)
    }

}

