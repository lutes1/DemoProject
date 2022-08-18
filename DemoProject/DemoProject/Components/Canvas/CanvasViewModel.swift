//
//  CanvasViewModel.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import UIKit

class CanvasViewModel: ObservableObject {
    internal init(image: UIImage, tilt: Double = 0, backgroundColor: UIColor = .clear, size: ImageMetadata.Size = .normal) {
        self.image = image
        self.tilt = tilt
        self.backgroundColor = backgroundColor
        self.size = size
    }
    
    @Published var image: UIImage
    @Published var tilt: Double = 0
    @Published var backgroundColor: UIColor = .clear
    @Published var size: ImageMetadata.Size = .normal
}
