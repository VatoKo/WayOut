//  
//  PlateScannerController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 02.06.21.
//

import UIKit
import AVFoundation
import MaterialComponents.MDCOutlinedTextField

protocol PlateScannerControllerDelegate: AnyObject {
    func plateScannerController(_ sender: PlateScannerController, didCapture photo: UIImage?)
}

class PlateScannerController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var plateMaskView: UIView!
    @IBOutlet weak var captureButton: MDCButton!
    
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var capturePhotoOutput: AVCapturePhotoOutput?
    
    var presenter: PlateScannerPresenter?
    weak var delegate: PlateScannerControllerDelegate?
    
}

// MARK: UIViewController Lifecycle
extension PlateScannerController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureButton()
        setupCameraAndRun()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNumberPlateMaskView()
    }
    
}

// MARK: Setup
extension PlateScannerController {
    
    private func setupCaptureButton() {
        captureButton.setTitle("Capture", for: .normal)
        captureButton.setTitleColor(.white, for: .normal)
        captureButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        captureButton.setBackgroundColor(.black)
        captureButton.layer.cornerRadius = 16
        captureButton.setElevation(.raisedButtonResting, for: .normal)
    }
    
    private func setupCameraAndRun() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input)
        
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput?.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOutput!)
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        previewView.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
    }
    
    private func addNumberPlateMaskView() {
        let path = UIBezierPath(roundedRect: previewView.frame, cornerRadius: 0)
        let scanningPath = UIBezierPath(roundedRect: self.plateMaskView.frame, cornerRadius: 16)
        path.append(scanningPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.5
        previewView.layer.addSublayer(fillLayer)
    }
    
}

// MARK: Touch Events
extension PlateScannerController {
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCapture(_ sender: MDCButton) {
        guard let capturePhotoOutput = capturePhotoOutput else { return }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
}

extension PlateScannerController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        guard error == nil, let photoSampleBuffer = photoSampleBuffer else {
            print("Error capturing photo: \(String(describing: error))")
            return
        }
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(
                forJPEGSampleBuffer: photoSampleBuffer,
                previewPhotoSampleBuffer: previewPhotoSampleBuffer
        ) else { return }
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.plateScannerController(self, didCapture: capturedImage)
        }
    }
    
}

extension PlateScannerController: PlateScannerView {
    
}

extension PlateScannerController {
    
    static func configured() -> PlateScannerController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PlateScannerController") as! PlateScannerController
        let configurator = PlateScannerConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}
