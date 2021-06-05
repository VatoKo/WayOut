//
//  PlateRecognizer.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 05.06.21.
//

import UIKit
import Vision

typealias PlateRecognizerCompletion = (_ recognitionResult: Result<PlateRecognitionData, Error>) -> Void

struct PlateRecognitionData {
    let recognizedNumberPlate: String
    let rectangeBoundedImage: UIImage
}

protocol PlateRecognizer {
    func recognizePlateNumber(on image: UIImage, completion: @escaping PlateRecognizerCompletion)
}

class PlateRecognizerImpl: PlateRecognizer {
    
    private var imageToProcess: UIImage?
    private var recognitionHandler: PlateRecognizerCompletion?
    private var objectBounds = CGRect()
    
    func recognizePlateNumber(on image: UIImage, completion: @escaping PlateRecognizerCompletion) {
        imageToProcess = image
        recognitionHandler = completion
        textRecognition(image: image.cgImage!)
    }
    
    
    private func textRecognition(image: CGImage) {
        let textRecognitionRequest = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.recognitionLanguages = ["en_US"]
        textRecognitionRequest.usesLanguageCorrection = false

        let textRequest = [textRecognitionRequest]
        let imageRequestHandler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform(textRequest)
            } catch let error {
                print("Error: \(error)")
                self.recognitionHandler?(.failure(PlateRecognizerRequestPerformError()))
            }
        }
        
    }
    
    
    private func handleDetectedText(request: VNRequest?, error: Error?) {
        if let error = error {
            print("ERROR: \(error)")
            self.recognitionHandler?(.failure(PlateRecognizerTextDetectionError()))
            return
        }
        guard let results = request?.results, results.count > 0 else {
            self.recognitionHandler?(.failure(PlateRecognizerNoTextRecognizedError()))
            return
        }
        for result in results {
            if let observation = result as? VNRecognizedTextObservation {
                for text in observation.topCandidates(1) {
                    DispatchQueue.main.async {
                        do {
                            var t: CGAffineTransform = CGAffineTransform.identity;
                            t = t.scaledBy( x: self.imageToProcess!.size.width, y: -self.imageToProcess!.size.height);
                            t = t.translatedBy(x: 0, y: -1);
                            self.objectBounds = observation.boundingBox.applying(t)
                            let newString = text.string.replacingOccurrences(of: " ", with: "")
                            let pattern = "[A-Z]{2}-[0-9]{3}-[A-Z]{2}"
                            let resultOfRegEx = newString.range(of: pattern, options: .regularExpression)
                            if ((resultOfRegEx) != nil) {
                                let imageWithBoundingBox = self.drawRectangleOnImage(
                                    image: self.imageToProcess!,
                                    x: Double(self.objectBounds.minX),
                                    y: Double(self.objectBounds.minY),
                                    width: Double(self.objectBounds.width),
                                    height: Double(self.objectBounds.height)
                                )
                                self.recognitionHandler?(.success(.init(recognizedNumberPlate: text.string, rectangeBoundedImage: imageWithBoundingBox)))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func drawRectangleOnImage(image: UIImage, x: Double, y: Double, width: Double, height: Double) -> UIImage {
        let imageSize = image.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: CGPoint.zero)
        let rectangleTodraw = CGRect(x: x, y: y, width: width, height: height)
        
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(5.0)
        context?.addRect(rectangleTodraw)
        context?.drawPath(using: .stroke)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
