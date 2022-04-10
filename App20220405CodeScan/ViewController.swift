//
//  ViewController.swift
//  App20220405CodeScan
//
//  Created by grace on 2022/4/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    let avCaptureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCodeScan()
    }

    func setCodeScan() {
        // 設定輸出設備
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else { return }
        avCaptureSession.addInput(avCaptureInput)
        
        // 設定輸出代理
        // 逎立輸出物件，並設定ViewController為代理人
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        // 輸出時，使用主線程
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // session加上輸出
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        // 輸出需指定類別
        avCaptureMetadataOutput.metadataObjectTypes
            = [AVMetadataObject.ObjectType.qr,
               AVMetadataObject.ObjectType.code128,
               AVMetadataObject.ObjectType.code39,
               AVMetadataObject.ObjectType.code93,
               AVMetadataObject.ObjectType.upce,
               AVMetadataObject.ObjectType.pdf417,
               AVMetadataObject.ObjectType.ean13,
               AVMetadataObject.ObjectType.aztec]
        
        // 建一UIView做為輸出的影像，把圖層加到畫面中的圖層，讓使用者看到
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = myView.bounds
        self.myView.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        // 第一次啟動
        avCaptureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let machineReabableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            myLabel.text = machineReabableCode.stringValue
            avCaptureSession.stopRunning()
        }
    }
    
    @IBAction func doReScan(_ sender: Any) {
        avCaptureSession.startRunning()
    }
    
}

