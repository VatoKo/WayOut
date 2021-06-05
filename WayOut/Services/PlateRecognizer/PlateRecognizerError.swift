//
//  PlateRecognizerError.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 05.06.21.
//

import Foundation

protocol PlateRecognizerError: Error {
    var localizedDescription: String { get }
}

struct PlateRecognizerRequestPerformError: PlateRecognizerError {
    var localizedDescription: String = "Could not perform recognition request"
}

struct PlateRecognizerTextDetectionError: PlateRecognizerError {
    var localizedDescription: String = "Could not perform text detection"
}

struct PlateRecognizerNoTextRecognizedError: PlateRecognizerError {
    var localizedDescription: String = "Could not recognize any text"
}

struct PlateRecognizerNoPlateRecognizedError: PlateRecognizerError {
    var localizedDescription: String = "Could not recognize any number plate"
}

