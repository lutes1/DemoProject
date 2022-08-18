//
//  ImageMetadata.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import UIKit

struct ImageMetadata {
    enum Size: Int, CaseIterable {
        case extraSmall
        case small
        case normal
        case large
        case extraLarge
        
        var ammount: Double {
            switch self {
                case .extraSmall: return 0.2
                case .small: return 0.5
                case .normal: return 1
                case .large: return 1.1
                case .extraLarge: return 1.2
            }
        }
        
        var title: String {
            switch self {
                case .extraSmall: return "20%"
                case .small: return "50%"
                case .normal: return "100%"
                case .large: return "110%"
                case .extraLarge: return "120%"
                    
            }
        }
    }
    
    var tilt: Double = 0
    var backgroundColor: UIColor = .clear
    var size: Size = .normal
}
