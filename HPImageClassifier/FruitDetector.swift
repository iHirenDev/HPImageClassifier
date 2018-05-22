//
//  FruitDetector.swift
//  HPImageClassifier
//
//  Created by Hiren Patel on 22/5/18.
//  Copyright © 2018 com.hiren. All rights reserved.
//

import UIKit
import Vision

class FruitDetector {
    static func startFruitDetection (_ imageView:UIImageView, completion: @escaping (_ classifications:[String]) -> Void) {
        
        let imageOrientation = CGImagePropertyOrientation(imageView.image!.imageOrientation)
        
        let visionRequestHandler = VNImageRequestHandler(cgImage: imageView.image!.cgImage!, orientation: imageOrientation, options: [:])
        

        guard let fruitModel = try? VNCoreMLModel(for: AppleOrangeClassifier().model) else {print("Could not load model"); return}
        
        let fruitDetectionRequest = VNCoreMLRequest(model: fruitModel) {(request, error) in
            
            guard let observations = request.results else {print("no results"); return}
            
            let classifications = observations
                .compactMap({$0 as? VNClassificationObservation})
                .filter({$0.confidence > 0.9})
                .map({$0.identifier})
            
            completion(classifications)
            
        }
        
        do {
            try visionRequestHandler.perform([fruitDetectionRequest])
        }catch{
            print(error.localizedDescription)
        }
        
    }
}

extension CGImagePropertyOrientation {
    init(_ orientation: UIImageOrientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}
