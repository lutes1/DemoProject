//
//  Page.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import Foundation

enum Page: Identifiable {
    case tilt
    case background
    case size
    
    var id: Self {
        self
    }
}
